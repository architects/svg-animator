component "TweenEditor"

state
  target: undefined

view ->
  <div className="app tween-editor">
    <div className="ui form">
      <div className="field">
        <label>Target</label>
        <input type="text" value={@state.target} defaultValue={@state.repeat} onChange={@fieldWasChanged} />
      </div>
    </div>
  </div>

end(module)
