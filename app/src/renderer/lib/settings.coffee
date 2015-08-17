path = require("path")

global.SETTINGS = {
  sourceRoot: path.join(__dirname, '..', '..')
  logo_image: "images/logo-white.svg"
  archi:
    bin_path: "/Users/jonathan/Gems/architects-toolkit/bin/archi"
  user:
    blueprints_folder: "/Users/jonathan/Architects/blueprints"

  # http, or native
  integration_mode: "http"
}

SETTINGS.api = {
  proto: "https"
  host: "blueprints.architects.io"
  prefix: "briefcases"
}
