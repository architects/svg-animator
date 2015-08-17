component "Grid"

properties
  columns: 16 
  stackable: true

property types
  columns: "number"

helpers
  getClassNames: ->
    classes =
      "ui grid": true
      "stackable": !!@props.stackable
      "centered": !!@props.centered
      "doubling": !!@props.doubling
      "vertically padded": !!@props.verticallyPadded
      "horizontally padded": !!@props.horizontallyPadded
      "equal height": !!(@props.equalHeightColumns || @props.equal)

    width = "#{ util.wordsForNumber(@props.columns) } columns"
    classes[width] = true
    classes[@props.classes] = true if @props.classes

    cx(classes)

view ->
  <div className={@getClassNames()}>
    {@props.children}
  </div>

module.exports = finished()
