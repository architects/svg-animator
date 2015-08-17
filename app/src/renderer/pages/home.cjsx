page("HomePage")

state
  currentFile: "/Users/jonathan/Architects/apps/svg-animator/app/static/architects-logo.svg"

helpers 
  buildGraph: util.buildGraph

  openSvgFile: (currentFile)->
    @setState {currentFile}

events
  componentDidMount: ->
    @timelines ||= []

    _.delay =>
      @forceUpdate()
    , 10
  
  propertyWasEdited: (newValues, selector, event)->
    target = event.target

    svg = @refs.object_browser.svg

    $(selector, svg).attr(target.name, newValues[target.name]) 
  
  controlsDidChange: (controlsState)->
    if controlsState.control is "play" and controlsState.playing is true
      console.log "Playing"
      _(@timelines).invoke("play")

  objectWasSelected: (e)->
    target = $(e.target)

    if selector = target.data('selector')
      state = {}
      state.fields = util.objectify $(selector)
      state.selector = selector

      @refs.property_editor.setState(state)

view ->
  <div className="ui twelve column grid full height">
    <div className="three wide column object-browser-wrapper full height">
      <ObjectBrowser ref="object_browser" currentFile={@state.currentFile} object=".svg-container svg" onSelection={@objectWasSelected} />
      <PropertyEditor ref="property_editor" root=".svg-container svg" propertyWasEdited={@propertyWasEdited} />
    </div>
    <div className="thirteen wide column svg-preview-wrapper full height">
      <div style={height:"60%", position: "relative"}>
        <AnimationControls ref="animation_controls" controlWasClicked={@controlsDidChange} />
        <Svg ref="svg_container" className="svg-container" src={@state.currentFile} />
      </div>
      <div style={height:"40%"} className="ui inverted">
        <TimelineVisualizer timelines={@timelines} ref="timeline_visualizer" />
      </div>
    </div>
  </div>

end(module)


