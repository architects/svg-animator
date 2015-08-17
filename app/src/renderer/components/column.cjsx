component "Column"

view ->
  <div className="column #{ @props.wide }">
    {@props.children}
  </div>

module.exports = finished()
