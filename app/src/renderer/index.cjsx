global            = if typeof(window) isnt "undefined" then window else global

require "codemirror/lib/codemirror.css"
require "./styles/index.less"

$                 = require "../../static/jquery"
_                 = require "underscore"
str               = require "underscore.string"
key               = require "keymaster"
settings          = require "./lib/settings"
path              = require "path"

global.external = (m)-> window.require(m)

window.Electron = 
  ipc: external("ipc")
  remote: external("remote")

global.React           = require("react/addons")
global.Router          = require "react-router-component"

Locations       = Router.Locations
Location        = Router.Location

global.util         = require "./lib/util"
global.factory      = React.createFactory
global.Link         = Router.Link
global._            = _; _.str = str
global.$            = $
global.jQuery       = $
global.semantic     = require("../../static/semantic/semantic.min")

# Mixins
global.PageTrackingMixin    = require("./lib/page_tracking_mixin")

sugar  = require("./sugar").globalized()

require "./components"
require "./layouts"
require "./pages"
require "./models"
require "./app-components"

global.Application = React.createClass
  displayName: "Application"

  isDevMode: ->
    Electron.remote.getCurrentWindow().loadSettings.devMode is true
  
  componentWillUnmount: ->
    @sidebar?.hide()
    @getDrawer()?.hide()

  componentDidMount: ->
    @setupExternalElements()
    @setupKeyBindings()
  
  setupExternalElements: ->

  setupKeyBindings: ->
    @setupProductionKeyBindings()

  setupProductionKeyBindings: ->
    cmd = "⌘"

    key "#{cmd}+left", "all", ->
      window.history.back()

    key "#{cmd}+right", "all", ->
      window.history.forward()

    key "#{cmd}+r", "all", ->
      window.location.reload()
  
    key "#{cmd}+j", "all", =>
      @forceUpdate()
    
    key "#{cmd}+o", "all", =>
      fileToOpen = Electron.remote.require("dialog").showOpenDialog properties: ["openFile"]
      App.refs.home.openSvgFile(fileToOpen[0]) if fileToOpen?.length is 1

    key "#{cmd}+q", "all", ->
      Electron.remote.require('app').quit()

    key "#{cmd}+alt+I", "all", =>
      w = Electron.remote.getCurrentWindow()
      
      if @devToolsOpen isnt true
        w.openDevTools()
        @devToolsOpen = true
      else
        w.closeDevTools()
        @devToolsOpen = false
  
  setupDevModeKeyBindings: ->
    cmd = "⌘"
   
  updateSideMenu: (activeItem)->
    return unless @isDevMode()
    @refs.sideMenu?.setState({activeItem})
 
  enableBottomDrawer: ->
    @_bottomDrawer ||= React.render(<Drawer orientation="bottom" element="#bottom-drawer" />, el("bottom-drawer"))
    @_bottomDrawer.show()
  
  getDrawer: ->
    @_bottomDrawer
  
  getCurrentDocument: ->
    @state?.currentDocument
  
  getEditorDrawerContents: ->
    @getDrawer()?.getValue()
 
  render: ->
    classes = cx("full height container": true)
    
    <HomePage ref="home" />

# cleans up the component definition sugar
onReady ->
  ipc = Electron.ipc
  remote = Electron.remote
  global.App = React.render(<Application />, document.getElementById('app')) 
, false #pass false to ensure webpack hot reload works
