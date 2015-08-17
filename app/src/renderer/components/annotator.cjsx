component "Annotator"

state
  annotations: []
  mode: ""

helpers
  onClick: (e)->
    pos = util.relativePosition(e,@)

    if @state.mode is "new annotations"
      @state.annotations ||= []
      @state.annotations.push(pos) if pos.top && pos.left
      @forceUpdate()

  displayAnnotationBubbles: ->
    _(@state.annotations || []).map (annotation,index)->
      styles = 
        position: "absolute"
        zIndex: 5
        top: "#{annotation.top}px"
        left: "#{annotation.left}px"

      <div key="annotation-#{index}" style={styles} className="app annotation marker">{index + 1}</div>

view ->
  classes = cx
    "clickable area": true
    "empty": !!(@props.source.match(/empty-frame.html/))

  <div className="annotator">
    <img src={@props.source} />
    <div className={classes} onClick={@onClick}>
      {@displayAnnotationBubbles()}
    </div>
  </div>

module.exports = finished()
