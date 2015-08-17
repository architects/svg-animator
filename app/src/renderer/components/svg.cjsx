component "Svg"

view ->
  props = _(@props).clone()
  value = props.value
  src   = props.src
  
  delete(props.value)
  delete(props.src)

  if src and !value
    value = Native.readFile(src)
  

  if src && value
    value = value.replace(/\<svg\s/i, "<svg data-path='#{ src }' ")

  props.dangerouslySetInnerHTML={__html: value}

  <span {...props} />

end(module)
