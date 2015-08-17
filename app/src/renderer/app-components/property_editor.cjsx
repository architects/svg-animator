component "PropertyEditor"

view ->
  return @emptyState() unless @state?.selector

  <div className="app property-editor">
    <div className="ui header white">
      {@state?.selector}
    </div>

    {@buildForm()}
  </div>

events
  onFieldChange: (e)->
    fields = @state.fields || {} 
    fields[e.target.name] = e.target.value
    @setState(fields: fields)
    @props.propertyWasEdited?(fields, @state.selector, e)

helpers 
  emptyState: ->
    <div></div>

  buildForm: ->
    keys = _.keys(@state.fields || {})

    items = _(keys).map (property)=>
      fields.for(property, @state.fields[property], @onFieldChange)

    <div className="ui form inverted">
      {_(items).compact()}
    </div>


end(module)

# Internal Helpers

fields =
  for: (property, value, changeHandler)->
    switch property
      when "stroke", "fill"
        <div key={property} className="ui field">
          <label>{property}</label>
          <input name={property} type="color" value={value} defaultValue={value} onChange={changeHandler} />
        </div>
      when "stroke-width"
        <div key={property} className="ui field">
          <label>{property}</label>
          <input name={property} type="range" value={value} defaultValue={value} onChange={changeHandler} />
        </div>
      when "opacity"
         <div key={property} className="ui field">
          <label>{property}</label>
          <input name={property} type="range" value={value} defaultValue={value} onChange={changeHandler} min=0 max=1 step="0.05" />
        </div>
      when "d", "id", "class", "selector"
        <div key={property} />
      else
        <div key={property} className="ui field">
          <label>{property}</label>
          <input type="text" value={value} defaultValue={value} onChange={changeHandler} />
        </div>
