IS_MOBILE = typeof navigator == 'undefined' or navigator.userAgent.match(/Android/i) or navigator.userAgent.match(/webOS/i) or navigator.userAgent.match(/iPhone/i) or navigator.userAgent.match(/iPad/i) or navigator.userAgent.match(/iPod/i) or navigator.userAgent.match(/BlackBerry/i) or navigator.userAgent.match(/Windows Phone/i)

if !IS_MOBILE
  CodeMirror = require('codemirror/lib/codemirror.js')

require "codemirror/keymap/sublime"
require "codemirror/keymap/vim"

require "codemirror/mode/css/css"
require "codemirror/mode/coffeescript/coffeescript"
require "codemirror/mode/gherkin/gherkin"
require "codemirror/mode/htmlmixed/htmlmixed"
require "codemirror/mode/haml/haml"
require "codemirror/mode/jade/jade"
require "codemirror/mode/ruby/ruby"
require "codemirror/mode/sass/sass"
require "codemirror/mode/slim/slim"
require "codemirror/mode/yaml/yaml"
require "codemirror/mode/markdown/markdown"

require "codemirror/theme/monokai.css"
require "codemirror/theme/eclipse.css"
require "codemirror/theme/twilight.css"
require "codemirror/theme/vibrant-ink.css"

CodeMirror.commands.save = ->
  App.triggerSaveFlow()

CodeMirrorEditor = React.createClass(
  displayName: "Editor"

  propTypes:
    value: React.PropTypes.string
    defaultValue: React.PropTypes.string
    style: React.PropTypes.object
    className: React.PropTypes.string
    onChange: React.PropTypes.func

  componentDidMount: ->
    @editor = CodeMirror.fromTextArea(@refs.editor.getDOMNode(), @props)

    @editor.on 'change', @handleChange
  
  loadDocument: (briefDocument)->
    @setState(value: briefDocument.content)
    @updateValue()
  
  getValue: ->
    @editor?.getValue() || @state?.value || @props.value

  updateValue: (value)->
    @editor.setValue(value || @state?.value || @props.value)

  _shouldComponentUpdate: ->
    false

  handleChange: ->

  render: ->
    cmd = "⌘"

    editor = React.createElement('textarea',
      ref: 'editor'
      value: @state?.value || @props.value
      readOnly: @props.readOnly
      defaultValue: @props.defaultValue
      onChange: @props.onChange
      style: @props.textAreaStyle
      extraKeys: @props.extraKeys || {"#{cmd}+s":false, "Command + s": false},
      className: @props.textAreaClassName or @props.textAreaClass)
        

    React.createElement 'div', {
      style: @props.style
      className: @props.className
    }, editor
)

module.exports = CodeMirrorEditor
