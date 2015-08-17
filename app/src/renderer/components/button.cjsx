component "Button"

properties
  label: ""

view ->
  classes = cx({})
  
  button = @ 

  if @props.action is "link"
    clickHandler = -> window.location = button.props.target

  clickHandler = @props.onClick if @props.onClick

  <div className="ui button #{ classes }" onClick={clickHandler}>
    {<i className="icon #{@props.icon}" /> if @props.icon}
    {@props.label}
  </div>

end(module)
