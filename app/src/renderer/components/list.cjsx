component "List"

properties 
  bulleted: false
  ordered: false
  link: false
  horizontal: false
  relaxed: false
  very: false
  divided: false
  celled: false

view ->
  classes = _.extend(@props, {"ui": true, "list": true})
  
  itemComponent = @props.itemComponent || "div"

  content = if _.isArray(@props.items)
              _(@props.items).map (item)->
                React.createElement(itemComponent, item: item)
            else
              @props.children

  <div className={cx(classes)}>
    {content}
  </div>

module.exports = finished()
