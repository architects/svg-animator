component "SplitLayout"

view ->
  mainColumnWidth = "twelve wide"

  <div className="split layout full height">
    <div className="inner">
      {@props.children}
    </div>
  </div>

end(module)
