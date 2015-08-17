register "CardGrid"

view ->
  gridProps = _(@props).pick('columns','stackable','doubling', 'classes')
  
  index = 0

  groups = util.chunk(@props.children, @props.columns)
  card = @props.card
  cardProps = @props.cardProps 
  
  rows = _(groups).map (group, rowIndex)->
    columns = _(group).map (item, colIndex)->
      cardProps ||= {}
      cardProps.item ||= item
      item = React.createElement(card, cardProps, item) if card

      <Column key={colIndex}>
        {item}
      </Column>
    
    <Row key={rowIndex}>{columns}</Row>
   
  <Grid {...gridProps}>
    {rows}
  </Grid>

module.exports = finished()
