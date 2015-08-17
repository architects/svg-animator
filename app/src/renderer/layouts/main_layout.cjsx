component "MainLayout"

view ->
  mainColumnWidth = "twelve wide"

  <div className="main layout">
    <div className="inner">
      {@props.children}
    </div>
  </div>

end(module)
