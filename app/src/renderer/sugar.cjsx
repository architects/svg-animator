module.exports = sugar = {}

class ComponentDefinition
  constructor: (name, options={})->
    @name = name
    @completed = false
    @type = options.type || "component"
    @mixins = options.mixins if options.mixins?.length > 0

    global.previousComponent = @
  
  state: (initialState)->
    @initialState = initialState
    @
  
  property: (propertyTypes)->
    @types(propertyTypes)
    @

  watches: (watchable)->
    @mixins ||= []

    if _.isString(watchable)
      @mixins.push @store(watchable)
    else
      @mixins.push(watchable)

    @

  store: (storeName)->
    console.log "The Concept of Flux Stores are Deprecated in this app", console.trace()
    #StoreWatchMixin(storeName)

  types: (propertyTypes)->
    for key, val of propertyTypes when _.isString(val) 
      propertyTypes[key] = React.PropTypes[val]

    @_types = propertyTypes

  properties: (defaultProperties)->
    @defaultProperties = defaultProperties
    @
  
  view: (v)->
    @_view = v
    @
  
  helpers: (helpers={})->
    @helpers ||= {}
    @helpers = _.extend(@helpers, helpers)
    @

  classMethods: (classMethods={})->
    @classMethods ||= {}
    @classMethods = _.extend(@classMethods, classMethods)
    @

  events: (helpers={})->
    @helpers ||= {}
    @helpers = _.extend(@helpers, helpers)
    @
  
  finished: (cb)->
    @register(cb)

  register: (cb)->
    @completed = true
    
    name = @name
    definition = _.extend @helpers || {},
      displayName: @name
      getComponentName: -> name
      render: @_view || (->)
   
    if @classMethods
      definition.statics = _.extend((definition.statics || {}), @classMethods) 
    
    if @mixins?.length > 0
      definition.mixins = @mixins
 
    @extraDefaults = {}

    me = @
         
    if _.isFunction(@defaultProperties)
      definition.getDefaultProps = ->
        _.extend(me.extraDefaults, me.defaultProperties() || {})

    else if _.isObject(@defaultProperties)
      definition.getDefaultProps = ->
        _.extend(me.extraDefaults, me.defaultProperties || {})
    
    if _.isFunction(@initialState)
      definition.getInitialState = @initialState

    else if _.isObject(@initialState)
      definition.getInitialState = -> 
        me.initialState
    
    if _.isArray(@mixins) and @mixins.length > 0
      definition.mixins = @mixins
    
    if _.isObject(@_types)
      definition.propTypes = @_types
    
    k = React.createClass(definition)
    cb?(k)
    
    if @type is "component"
      global.setComponent?(@name, k)

    if @type is "page"
      global.setPage?(@name, k)

    global.previousComponent = undefined
    k

global.previousComponent = undefined

# implement a poor man's method missing for certain functions that get used
# during the react component definition stage
originals = {} 

delegate = (fnName)->
  sugar[fnName] = ->
    global.previousComponent?[fnName]?.apply(global.previousComponent, arguments)

for fn in ['properties', 'watches', 'store', 'types', 'property', 'helpers', 'events', 'view', 'state', 'classMethods', 'finished']
  originals[fn] = global[fn]
  delegate(fn) 

# lets the component definition files 
# start off a new definition by using the local function 'register'
global.register = (name, options={})-> 
  global.previousComponent = new ComponentDefinition(name, options)

# lets the component definition finish registering
# expects the developer to pass its module reference
global.end = (mod)->
  if global.previousComponent?
    mod.exports = global.previousComponent.finished()

# lets the component definition start declaring a specific page type component
global.page = (name, options={})->
  options.mixins ||= [
    PageTrackingMixin
  ]
  options.type = "page"
  global.previousComponent = new ComponentDefinition(name, options)

# an alias for register that uses a component type, as opposed to a page.
global.component = (name, options={})->
  options.type = "component"
  global.previousComponent = new ComponentDefinition(name, options)

global.el = (id)-> document.getElementById(id)
global.cx = React.addons.classSet

global.depends = (fn)->
  map = fn()
  global[prop] = val for prop, val of map


global.onReady = (fn, shouldFinish=true)->
  sugar.finish() if shouldFinish
  $(fn)

# makes the sugar available to all the scripts
sugar.globalized = ->
  for prop, val of originals
    global[prop] = sugar[prop]

  sugar

# cleans up after the sugar
sugar.finish = ->
  delete(global.page)
  delete(global.component)
  delete(global.register)
  delete(global.end)
  delete(global.onReady)

  for prop, val of originals
    global[prop] = val


