component "Breadcrumb"

properties
  chunks: []

view ->
  items = @props.chunks
  
  if items.length is 0
    items.push ["#","Home"]
  
  lastItem = items.pop()

  sections = _(items).map (item, index)->
    [href, title] = item

    [
      React.createElement("a", {className: "section", key: index, href: href, title: title}, title)
      React.createElement("i", {className:"ui icon right chevron divider", key: "icon-#{index}"})
    ]
  
  unless _.isEmpty(lastItem)
    sections.push (-> 
      <span key="last-section" className="active section">{lastItem[1]}</span>
    )()

  <div className="ui breadcrumb">
    {_(sections).flatten()}
  </div>

end(module)
