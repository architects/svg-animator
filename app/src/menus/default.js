module.exports = [{
  "submenu":[{
    "label": "Preferences",
    "accelerator": "Command+,",
    "selector": "preferences"
  }]
},{
  "label": "Navigate",
  "submenu":[{
    "accelerator": "Command+1",
    "label": "Preview Mode",
    "selector": "previewMode:"
  },{
    "type": "separator"
  },{
    "accelerator": "Command+2",
    "label": "Editor Mode",
    "selector": "editorMode:"
  },{
    "accelerator": "Command+3",
    "label": "Integrations",
    "selector": "integrations:"
  }]
},{
  label: "Show",
  submenu:[{
    "label": "Table of Contents",
    "accelerator": "Command+b",
    "selector":"tableOfContents"
  },{
    "label": "Document Editor",
    "accelerator": "Command+e",
    "selector": "documentEditor"
  }]
}]
