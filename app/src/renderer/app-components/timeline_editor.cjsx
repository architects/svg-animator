component "TimelineEditor"

events
  fieldWasChanged: (e)->
    field = e.target
    timeline = @props.timeline
    method = field.attributes.name.value
    s = {}
    
    value = field.value
    
    if field.type is "checkbox"
      value = !!field.checked

    s[field] = value 
    @setState(s)

    if typeof timeline[method] is "function"
      timeline[method](value)
    

state
  repeat: 0
  repeatDelay: 0
  timeScale: 1
  yoyo: true

view ->
  @displayForm() if @props.timeline
  
helpers
  displayForm: ->
    timeline = @props.timeline

    <div className="app timeline-editor ">
      <div className="ui inverted form">

      </div>
    </div>

end(module)
