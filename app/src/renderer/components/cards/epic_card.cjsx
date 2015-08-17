component "EpicCard"

helpers
  onClick: (e)->
    item = @props.item
    handler = @props.onSelection
    handler.call(@, item)

property types
  onSelection: "func"

view ->
  {header, key, description} = format(@props.item)

  <div data-key={key} key={key} className="ui card epic-card">
    <div className="content">
      <div className="header">{header}</div>
      <div className="description">{description}</div>
    </div>
    <div className="extra content">
      <span className="right floated pencil" onClick={@onClick}>
        <i className="icon pencil" />
        Edit
      </span>
    </div>
  </div>

module.exports = finished()

format = (model)->
  header: model.data.title || model.extracted.title || model.title 
  description: model.extracted.paragraph
  key: model.path
