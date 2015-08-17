debounce = (fn)-> _.debounce(fn,10)

module.exports =
  componentDidMount: debounce ->
    @setCurrentPage()
    @updateSideMenu()

  updateSideMenu: ->
    sideMenuItem = parseInt(@props?.sideMenuItem || 1)
    App.updateSideMenu(sideMenuItem)

  setCurrentPage: ->
    global.getCurrentPageName = =>
      @getComponentName()

    global.getCurrentPage = =>
      @
