module.exports = layouts = {}

layouts.MainLayout = require "./main_layout"
layouts.SplitLayout = require "./split_layout"

_.extend(global, layouts)
