EventEmitter = require('events')

module.exports =
class Collection extends EventEmitter
  constructor: (models, options={})->
    @models = models
    @name = options.name

  # toJSON returns a native JS structure representation
  # of the models.  Accepts options:
  #
  # format: a function which gets called
  # in the context of the collection, with the following arguments:
  #
  # - model
  # - index
  # - collection
  #
  toJSON: (options={})->
    collection = @
    @models

  get: (slug)->
    _(@models).find (model)->
      model.slug is slug

  first: (args...)->
    _(@models).first()

  last: (args...)->
    _(@models).last()

  at: (index)->
    @models[index]

  select: (args...)->
    _(@models).select(args...)

  reject: (args...)->
    _(@models).reject(args...)

  find: (args...)->
    _(@models).find(args...)

  pluck: (args...)->
    _(@models).pluck(args...)

  reduce: (args...)->
    _(@models).reduce(args...)

  map: (args...)->
    _(@models).map(args...)
