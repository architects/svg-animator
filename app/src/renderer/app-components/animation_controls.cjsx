component "AnimationControls"

state
  playing: false
  stopped: true

helpers
  stopButtonWasClicked: ->
    @setState(stopped: true, playing: false)
    @props.controlWasClicked?(_.extend(@state, stopped: true, playing: false))

  playButtonWasClicked: ->
    @setState(stopped: (stopped=!@state.playing), playing: (playing=!@state.playing))
    @props.controlWasClicked?(_.extend(@state, control: "play", stopped: stopped, playing: playing))

view ->
  playButton = "play"
  playButton = "pause" if @state.playing is true

  <div className="app animation-controls">
    <div className="inner">
      <div onClick={@stopButtonWasClicked} className="ui icon button">
        <i className="icon stop" />
      </div>
      <div onClick={@playButtonWasClicked} className="ui icon button">
        <i className="icon #{ playButton }" />
      </div>
    </div>
  </div>

end(module)
