component "AutoGrid"

view ->
  gridProps = _(@props).pick('columns','stackable','doubling', 'classes', 'equal')
  
  index = 0

  groups = util.chunk(@props.children, @props.columns)
  
  rows = _(groups).map (group, rowIndex)->
    columns = _(group).map (item, colIndex)->
      <Column key={colIndex}>
        {item}
      </Column>
    
    <Row key={rowIndex}>{columns}</Row>
   
  <Grid {...gridProps}>
    {rows}
  </Grid>

module.exports = finished()
