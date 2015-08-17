component "ExpandButton"

view ->
  icon = "lightbulb"

  <div onClick={@props.onClick} className="app expand button">
    <i className="icon #{icon}" />
  </div>

end(module)
