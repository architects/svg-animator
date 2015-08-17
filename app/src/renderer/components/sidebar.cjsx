component "Sidebar"

properties
  launch: "#sidebar-toggle"
  element: "#right-sidebar"

events
  componentDidMount: ->
    $(@props.element).sidebar()
    $(@props.element).removeClass('left').addClass('right')
    $(@props.launch).on "click", @toggle

classMethods
  prepare: ->
    if $('#app').siblings('.sidebar').length is 0
      alert 'need to add sidebar'

helpers
  show: (options={})->
    $(@props.element).sidebar('show')
    @visible  = true
    @onHide   = options.onHide if _.isFunction(options.onHide)
    $('body').addClass('sidebar-active')
    @

  hide: ->
    $(@props.element).sidebar('hide')
    @visible = false 
    $('body').removeClass('sidebar-active')
    @onHide() if _.isFunction(@onHide)
    @onHide = undefined
    @
 
  isVisible: ->
    !!@visible

  toggle: ->
    if !!@visible then @hide() else @show()

view ->
  React.createElement(@props.inner, @props.sidebarViewProps || {})

module.exports = finished()
