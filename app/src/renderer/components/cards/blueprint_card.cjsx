component "BlueprintCard"

view ->
  {header, description, key, subheader, website, urgency, github} = format(@props.item)
  
  urgencyLabel = React.createElement("div", className:"ui label #{ labelMapping[urgency]}", "#{ _.str.capitalize(urgency) }")
  
  <div>
    <div className="ui header small">
      <div className="content">
        <a href="#/blueprints/#{key}" className="header">
          {header}
          <div className="sub header">{subheader if subheader}</div>
        </a>
      </div>
    </div>
    <div className="ui divider"></div>
    <div className="content">{description}</div>
    <div className="attached bottom">
      <div className="ui divider" />
      {urgencyLabel if urgency?}
    </div>
  </div>

module.exports = finished()

format = (model)->
  description = (model.summary.extracted.paragraph if model.summary?.extracted?.paragraph)
  summaryData = model.summary?.data
  
  header: model.name
  description: _.str.truncate(description, 225)
  key: model.key
  subheader: ("#{model.summary?.data?.client}" if model.summary?.data?.client)
  website: (summaryData?.website if summaryData?.website)
  github: (summaryData?.github_projects if summaryData?.github_projects)
  urgency: (summaryData?.urgency if summaryData?.urgency)

labelMapping = 
  low: "default"
  medium: "yellow"
  high: "red"
