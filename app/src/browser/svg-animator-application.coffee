BrowserWindow = require 'browser-window'
SVGAnimatorWindow = require './svg-animator-window'
Menu = require 'menu'
app = require 'app'
fs = require 'fs-plus'
ipc = require 'ipc'
path = require 'path'
os = require 'os'
net = require 'net'
url = require 'url'

{EventEmitter} = require 'events'

_ = require 'underscore-plus'


module.exports =
class SVGAnimatorApplication
  _.extend @prototype, EventEmitter.prototype

  @open: (options)->
    createSVGAnimatorApplication = ->
      options.commands = require("./commands")
      svgAnimatorApp = new SVGAnimatorApplication(options)

    createSVGAnimatorApplication()

  windows: null

  constructor:(options={})->
    @windows = []

    global.svgAnimatorApplication = this

    @handleEvents()

    @setupRendererBridge()

    @options = options
    @commands = options.commands.createRegistry(@)

    if options.briefcase
      target = path.join(path.resolve(options.briefcasesPath), options.briefcase)
      @setupFileWatcher(target, "file:change")

    if options.viewsPath
      target = path.resolve(options.viewsPath)
      @setupFileWatcher(target, "view:change")

    if options.localViewsPath
      target = path.resolve(options.localViewsPath)
      @setupFileWatcher(target, "view:change")

    @setupMenus()
    @addWindow()

  eachWindow: (fn)->
    fn(win) for win in @windows

  setupMenus: ->
    defaultMenu = require("../menus/default")
    menu = Menu.buildFromTemplate(defaultMenu)
    Menu.setApplicationMenu(menu)

  # The renderer process can dispatch commands through the
  # brief application, and these can run processes in the main process.
  #
  # To do this, the renderer process can just use ipc.send "app:command"
  dispatchCommand: (commandArgs)->
    action = commandArgs.action
    @commands[action]?.call(@, commandArgs)

  # Setup the communication between the
  # renderer instances and the SVGAnimatorApplication object
  setupRendererBridge: ->
    a = @

    ipc.on "app:command", (event, commandArgs)->
      event.preventDefault()
      a.dispatchCommand(commandArgs)

  setupFileWatcher: (target, triggerName)->
    ignored = (p)-> /^\./.test path.basename(p)
    watcher = require('chokidar').watch(target, ignoreInitial: true, __ignored: ignored, persistent: false, pollInterval: 50)

    watcher.on "all", (eventName, path)=>
      @eachWindow (w)->
        w = w.browserWindow.webContents
        w.send (triggerName || "file:change"), event: eventName, path: path

  # Setup different event handlers
  handleEvents: ->

  addWindow: (window)->
    window ||= new SVGAnimatorWindow(@options)
    @windows.push(window)

  exit: (status)->
    app.exit(status)
