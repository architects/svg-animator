component "SegmentGrid"

view ->
  <CardGrid columns={@props.columns} card={Segment}>
    {@props.children}
  </CardGrid>

end(module)
