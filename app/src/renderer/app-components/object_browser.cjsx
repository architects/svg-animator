component "ObjectBrowser"

state:
  current: 1

helpers
  componentWillReceiveProps: (newProps={})->
    if newProps?.currentFile isnt @props.currentFile && @props.currentFile?.length > 0
      _.defer =>
        @incrementCurrent()
  
  incrementCurrent: ->
    @setState(current: @state.current + 1)

  buildTree: ->
    groups = $("#{@props.object}[data-path='#{ @props.currentFile }'] g")

    rootLayers = _(groups).select (g)->
      $(g).parent().is("svg")
    
    depth = 0
    c = @

    gather = (el, baseSelector="", depth)=>
      depth = depth + 1
      children = _($(el).children()).map (child, index)->
        selector = childSelector = buildSelector(child)

        unless baseSelector is false
          selector = "#{ baseSelector } #{childSelector}"

        <div key={childSelector} className="item depth-#{depth}">
          <div className="header" data-selector={selector} onClick={c.props.onSelection}>
            {childSelector}
          </div>
          <div className="content">
            {gather(child, selector, depth) if $(child).children().length > 0}
          </div>
        </div>

      <div key={el.attributes.id.value} className="ui vertical inverted">
        {children}
      </div>
    

    <div className="root-layers">
      {
        _(rootLayers).map (rootLayer)->
          <div onClick={c.props.onSelection} data-selector="#{rootLayer.attributes.id.value}" className="inverted" key={rootLayer.attributes.id.value}>
            <div className="header">#{rootLayer.attributes.id.value}</div>
            {gather(rootLayer, false, 0)}
          </div>  
      }
    </div>

view ->
  <div data-current={@state?.current} className="app object-browser">
    {@buildTree()}
  </div>

end(module)

buildSelector = (el)->
  object = objectify(el)

  base = ""
  base += "##{el.attributes.id.value}" if el.attributes.id?
  base += ".#{el.attributes.class.value}" if el.attributes.class?

  base
  
objectify = (el)->
  pairs = _(el.attributes).reduce (memo, attr)->
    memo[attr.name] = attr.value
    memo
  , {}
