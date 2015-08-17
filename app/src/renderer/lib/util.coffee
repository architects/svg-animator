_     = require "underscore"
path  = require "path"

module.exports = util = {}

#_.extend(util, inflections: require("inflection"), string:require("underscore.string"))

util.chunk = (data, size)->
  _.chain(data).groupBy((element, index)-> Math.floor(index/size)).toArray().value()

# util.classify = (string, forceSingular = true)->
#   string = util.singularize(string) if forceSingular
#   classified = util.string.capitalize(util.string.camelize(string))
#   classified

# A safe way of arriving at a value from a string
# that does not use eval
#util.resolve = (string, root)->
#  parts = string.split('.')
#  _(parts).reduce (memo,part)->
#    memo[part]
#  , root

util.read = (value)->
  if _.isFunction(value) then value() else value

util.wordsForNumber = (number)->
  number = 0 if number is 0
  number = number - 1 if number > 1

  [
    "one"
    "two"
    "three"
    "four"
    "five"
    "six"
    "seven"
    "eight"
    "nine"
    "ten"
    "eleven"
    "twelve"
    "thirteen"
    "fourteen"
    "fifteen"
    "sixteen"
    "seventeen"
  ][number]

util.appendToHash = (value, follow=true)->
  current = window.location.hash
  window.location.hash = "#{current}#{value}" if follow
  "#{current}#{value}"

util.relativePosition = (e, reactComponent)->
  position = $(reactComponent.getDOMNode()).offset()

  top   = parseInt position.top
  left  = parseInt position.left
  x     = parseInt e.clientX
  y     = parseInt e.clientY

  coordinates = top: y - top, left: x - left

util.requiresAuth = ->
  val = util.storage.get("app:credentials")
  !!(_.isNull(val) || _.isUndefined(val) || _.isEmpty(val))

util.authToken = (provider="architects")->
  util.storage.get("app:credentials")?[provider]?.token

util.readFile = (relativePath)->
  p = path.join(SETTINGS.sourceRoot, relativePath)
  fs.readFileSync(p).toString()

util.storage =
  get: (key)->
    val = localStorage.getItem(key)
    val && JSON.parse(val)

  set: (key, value)->
    localStorage.setItem(key, JSON.stringify(value))

util.buildGraph = (selector)->
  svg = $(selector)
  rootLayer = svg.find("g").eq(0)

  gather = (el)->
    children = _($(el).children()).map (child)->
      if $(child).children().length is 0
        objectify(child)
      else
        _(objectify(child)).extend children: gather(child)

  _(objectify(rootLayer)).extend(children: gather(rootLayer))

util.objectify = (el)->
  if typeof el.is is "function"
    el = el[0]

  pairs = _(el.attributes).reduce (memo, attr)->
    memo[attr.name] = attr.value
    memo
  , {}

