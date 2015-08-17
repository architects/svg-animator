component "PersonaCard"

helpers
  openEditor: (e)->
    item = @props.item
    handler = @props.onSelection
    handler.call(@, item)

property types
  onSelection: "func"

view ->
  {header, key, description} = format(@props.item)

  <div data-key={key} key={key} className="ui card persona-card">
    <div className="content">
      <div className="header">{header}</div>
      <div className="description">{description}</div>
    </div>
    <div className="extra content">
      <span className="right floated pencil" onClick={@openEditor}>
        <i className="icon pencil" />
        Edit
      </span>
    </div>
  </div>

module.exports = finished()

format = (model)->
  description: _.str.truncate(model.extracted.paragraph, 150)
  header: model.data.title
  key: model.path
