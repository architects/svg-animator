component "Segment"

view ->
  classes = 
    "ui segment": true
    "stacked": !!@props.stacked
    "piled": !!@props.piled

  <div className={cx(classes)}>
    {@props.children}
  </div>

module.exports = finished()
