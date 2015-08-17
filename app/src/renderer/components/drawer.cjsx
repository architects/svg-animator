register "Drawer"

events
  componentDidMount: ->
    $(@props.element).sidebar()

  componentWillUnmount: ->
    $(@props.element).sidebar('hide')


state
  value: ""

properties
  mode: "markdown"
  theme: "twilight"

view ->
  <div className="drawer">
    <div className="ui inverted black">
      <Editor value={@state.value},
              mode={@props.mode},
              theme={@props.theme},
              lineNumbers=true
              gutter=true
              ref="main_editor"
              readOnly=false
              onChange={@editorDidChange} />
    </div>
  </div>

helpers
  loadDocument: (briefDocument)->
    @refs.main_editor?.loadDocument(briefDocument)

  show: (options={})->
    $(@props.element).addClass(@props.orientation).sidebar('show')
    @visible  = true
    @onHide   = options.onHide if _.isFunction(options.onHide)
    
    if currentDocument = App?.getCurrentDocument()
      @loadDocument(currentDocument)

    @

  hide: ->
    $(@props.element).sidebar('hide')
    @visible = false 
    @onHide() if _.isFunction(@onHide)
    delete(@onHide)
    @
  
  isVisible: ->
    !!@visible

  toggle: ->
    if !!@visible then @hide() else @show()

  setMode: (value)->
    @setProps(mode: value)
    @

  getValue: ->
    @refs.main_editor.editor.getValue()

end(module)
