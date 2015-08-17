module.exports = components = {}

components.PropertyEditor = require("./property_editor")
components.ObjectBrowser  = require("./object_browser")
components.TimelineVisualizer  = require("./timeline_visualizer")
components.TimelineEditor  = require("./timeline_editor")
components.TweenEditor  = require("./tween_editor")
components.AnimationControls  = require("./animation_controls")

_.extend(global, components)
