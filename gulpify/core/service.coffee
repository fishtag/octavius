class Service
  constructor: ->
    @_initEvents()
    @initialize() if @initialize

  _initEvents: () ->
    _.each @constructor::events, (func, event) =>
      _.bindAll @, func
      Radio.on event, @[func]

module.exports = Service