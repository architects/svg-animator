# This file is required from the package.json's main
#
global.shellStartTime = Date.now()

crashReporter = require 'crash-reporter'
app = require 'app'
fs = require 'fs-plus'
path = require 'path'
exec = require('child-process-promise').exec
optimist = require('optimist')

process.on 'uncaughtException', (error={}) ->
  console.log(error.message) if error.message?
  console.log(error.stack) if error.stack?

@cache = {}

start = (options)->
  try
    args = parseCommandLine(app, optimist)
  catch e
    console.log "Error parsing command line: #{ e.message }"

  try
    setupCoffeeCache(args)
  catch e
    console.log "Error setting up coffee cache: #{ e.message }"

  if args.devMode
    setupDevMode(startServer: options.devServer, args: args)

  addPathToOpen = (event, pathToOpen) ->
    event.preventDefault()
    args.pathsToOpen.push(pathToOpen)

  args.urlsToOpen = []

  addUrlToOpen = (event, urlToOpen) ->
    event.preventDefault()
    args.urlsToOpen.push(urlToOpen)

  app.on 'open-file', addPathToOpen
  app.on 'open-url', addUrlToOpen

  SVGAnimatorApplication = require('./svg-animator-application')

  app.on 'ready', ->
    app.removeListener 'open-file', addPathToOpen
    app.removeListener 'open-url', addUrlToOpen

    cwd = process.cwd()

    args.pathsToOpen = args.pathsToOpen.map (pathToOpen) ->
      pathToOpen = fs.normalize(pathToOpen)
      if cwd
        path.resolve(cwd, pathToOpen)
      else
        path.resolve(pathToOpen)

    SVGAnimatorApplication.open(args)

setupCrashReporter = ->
  crashReporter.start(productName: 'Architects SVG Toolkit', companyName: 'Architects.io, Inc.')

setupCoffeeCache = ->
  CoffeeCache = require 'coffee-cash'
  cacheDir = path.join(process.env.HOME, 'compile-cache')
  CoffeeCache.setCacheDirectory(path.join(cacheDir, 'coffee'))
  CoffeeCache.register()

setupDevMode = (o={})->
  wc = global.webpackConfig

  try
    o.startServer()
  catch e
    console.log "Error starting the dev server: #{ e.message }"

parseCommandLine = (app, optimist)->
  version = app.getVersion()
  options = optimist(process.argv[1..])
  options.usage """
  """

  args = options.argv

  pathsToOpen = args._[1..]

  devMode = !(!!args['disable-dev-mode'])

  {
    pathsToOpen,
    devMode
  }


module.exports = start
