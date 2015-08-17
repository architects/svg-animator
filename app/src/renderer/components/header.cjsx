register "Header"

properties ->
  branding = SVGAnimatorcase?.singleton()?.settings.branding || {}

  obj = 
    page: true
    size: "large"
    headerText: branding.title || "The Blueprint"
    icon: branding.icon || "lightbulb"
    subheading: branding.subheading

view ->
  hc = 
    ui: true
    header: true
    page: !!@props.page

  hc[@props.size] = true
  
  <div onClick={@props.onClick} className={cx(hc)}>
    {<i className="icon #{@props.icon}"></i> if @props.icon?.length > 0}
    <div className="content">
      {@props.title || @props.headerText}
      {<div className="sub header">{@props.subheading}</div> if @props.subheading}
    </div>
  </div>

module.exports = finished()
