component "Row"

view ->
  classes = 
    "row": true
    "equal height": !!@props.equal

  <div className={cx(classes)}>
    {@props.children}
  </div>

module.exports = finished()
