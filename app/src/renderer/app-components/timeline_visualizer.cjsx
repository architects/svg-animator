component "TimelineVisualizer"

properties
  timelines: []

helpers
  newTimeline: ->
    timeline = new TimelineMax
      useFrames: true
      yoyo: true
      paused: true
      repeat: 0
      repeatDelay: 0
      timeScale: 1

    timeline.to("svg #right-gem", 10, scale: 2)

    @props.timelines.push(timeline) 
    @forceUpdate()

  makeRow: (timeline, index=0)->
    <div onClick={@rowWasClicked} className="row" data-index={index} key="timeline-#{index}">
      {<div key={index} className="column section #{ index }">{index}</div> for index in [1..16]}
    </div>
  
  rowWasClicked: (e)->
    target = e.target
    index = $(e.target).closest('[data-index]').attr('data-index')
    timeline = @props.timelines[index]

    @setState(currentTimeline: timeline)

view ->
  <div className="app timeline-visualizer">
    <div className="ui header">
      Timeline Visualizer
      <div className="ui inverted black button right floated" onClick={@newTimeline}>
        <i className="icon plus sign "/>
      </div>
    </div>
    <div className="ui grid">
      <div className="column twelve wide">
        <div className="ui sixteen column vertically divided grid">
          {_(@props.timelines).map(@makeRow)}
        </div>
      </div>
      {<div className="column four wide">
        <TimelineEditor timeline={@state.currentTimeline}/>
      </div> if @state.currentTimeline}
    </div>
  </div>

end(module)
