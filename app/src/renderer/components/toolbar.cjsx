component "Toolbar"

properties
  floating: false

view ->
  styles = {}
  
  if @props.floating is true && @props.position is "top right"
    styles.position = "absolute"
    styles.top = "0px"
    styles.right = "0px"

  <div style={styles} className="app ui toolbar">
    {@props.children}
  </div>

end(module)
