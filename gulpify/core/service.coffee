class Service
  constructor: ->
    @_initEvents()
    @initialize() if @initialize

  _initEvents: ->
    _.each @constructor::events, (func, event) =>
      _.bindAll @, func
      service = @constructor.name.replace('Service', '').toLowerCase()
      Radio.on "#{service}:#{event}", @[func]

module.exports = Service