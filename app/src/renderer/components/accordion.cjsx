component "Accordion"

properties ->
  items: []
  titleMethod: "title"
  panelClass: "div"

helpers
  componentDidMount: ->
    $(".ui.accordion", @getDOMNode()).accordion()

  createTitleWrapper: (item, index)->
    title = item[@props.titleMethod]
    cls = 
      title: true
      active: index is 0

    <div className={cx(cls)} key="title-#{index}">
      <i className="dropdown icon" />
      {title}
    </div>

  createContentWrapper: (item, index)->
    cls = 
      content: true
      active: index is 0

    <div key="content-#{index}" className={cx(cls)}>
      {React.createElement(@props.panelClass, {className:"content", item: item})}
    </div>

  buildPanels: ->
    items = @props.items
    
    panels = []

    for item,index in items
      panels.push @createTitleWrapper(item,index)
      panels.push @createContentWrapper(item,index)   

    panels

view ->
  panels = @buildPanels()
  <div className="ui accordion">
    {panels}
  </div>

end(module)


