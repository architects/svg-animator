BrowserWindow = require 'browser-window'
app = require 'app'
path = require 'path'
fs = require 'fs'
url = require 'url'
_ = require 'underscore-plus'
{EventEmitter} = require 'events'

module.exports =
class SVGAnimatorWindow
  _.extend @prototype, EventEmitter.prototype

  browserWindow: null
  loaded: null

  constructor: (settings={}) ->
    options =
      show: true
      title: 'Architects.io Writing Toolkit (alpha)'
      'web-preferences':
        'direct-write': true
        'subpixel-font-scaling': false

    @browserWindow = new BrowserWindow(options)

    @browserWindow.toggleDevTools()

    global.svgAnimatorApplication.addWindow(this)

    loadSettings = _.extend({}, settings)

    @setLoadSettings(loadSettings)

    @browserWindow.once 'window:loaded', =>
       @emit 'window:loaded'
       @loaded = true

  setLoadSettings: (loadSettingsObj)->
    loadSettings = _.clone(loadSettingsObj)
    delete loadSettings['windowState']

    @browserWindow.loadSettings = loadSettings

    @browserWindow.loadUrl url.format
      protocol: 'file'
      pathname: path.join(__dirname,'../../static/index.html')
      slashes: true
      hash: encodeURIComponent(JSON.stringify(loadSettings))

  getLoadSettings: ->
    if @browserWindow.webContents.loaded
      hash = url.parse(@browserWindow.webContents.getUrl()).hash.substr(1)
      JSON.parse(decodeURIComponent(hash))
