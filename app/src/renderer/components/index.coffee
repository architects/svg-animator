module.exports = components = {}

#require("." + /\.cjsx/i)

components.Header           = require("./header")
components.Breadcrumb       = require("./breadcrumb")
components.Sidebar          = require("./sidebar")
components.SideMenu         = require("./side_menu")
components.Divider          = require("./divider")
components.Grid             = require("./grid")
components.Row              = require("./row")
components.Column           = require("./column")

components.Button           = require("./button")
components.Toolbar          = require("./toolbar")

components.Drawer           = require("./drawer")
components.Editor           = require("./editor")
components.Accordion        = require("./accordion")
components.AutoGrid         = require("./card_grid")
components.CardGrid         = require("./card_grid")
components.SegmentGrid      = require("./segment_grid")
components.List             = require("./list")
components.Segment          = require("./segment")
components.PersonaCard      = require("./cards/persona_card")
components.BlueprintCard    = require("./cards/blueprint_card")
components.EpicCard         = require("./cards/epic_card")
components.Annotator        = require("./annotator")
components.HTMLSafe         = require("./html_safe")
components.ContentEditable  = require("./content_editable")
components.Svg              = require("./svg")

components.ExpandButton     = require("./buttons/expand_button")

_.extend(global, components)
