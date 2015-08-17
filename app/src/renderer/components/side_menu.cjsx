component "SideMenu"

state
  activeItem: 1

view ->
  cmd = "⌘"
  styles = {display: "block", paddingTop:"8px", opacity:"0.5", fontSize:"0.8em"}

  <div className="ui full height vertical inverted divided icon menu">
    <a onClick={@itemWasClicked} data-item=1 href="#/" className="item #{ 'active' if @state.activeItem is 1}">
      <i className="icon large lightbulb" />
      <span style={styles}>{cmd + "+1"}</span>
    </a>
    <a onClick={@itemWasClicked} data-item=2 href="#/models" className="item  #{ 'active' if @state.activeItem is 2}">
      <i className="icon large cogs" />
      <span style={styles}>{cmd + "+2"}</span>
    </a>
    <a onClick={@itemWasClicked} data-item=3 href="#/integrations" className="item #{ 'active' if @state.activeItem is 3}">
      <i className="icon large cloud alt" />
      <span style={styles}>{cmd + "+3"}</span>
    </a>
  </div>

events
  itemWasClicked: (e)->
    @setState(activeItem: parseInt(e.currentTarget.dataset.item)) if e.currentTarget.dataset?.item?

end(module)
