component "HTMLSafe"

properties
  tag: "div"

view ->
  html = @props.value
  React.createElement(@props.tag, className: @props.className, dangerouslySetInnerHTML: {__html: html})

end(module)
