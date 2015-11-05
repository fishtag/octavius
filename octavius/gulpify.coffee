require './core/globals'

global.Octavius = class Octavius
  log: require './core/log'
  develop: true
  watch: true

  constructor: ->
    @tasks = new (require './core/tasks')()
    @services = new (require './core/services')()
    @_started = false

  start: ->
    Octavius::log.info 'trying to start..'
    @_started = true
    @services.load () =>
      @webserver = new (require './core/web')(@services)
      @tasks.load().start()
      Octavius::log.info 'application is started!'

  stop: (callback) ->
    Octavius::log.info 'trying to stop..'
    @_started = false
    Octavius::log.info 'application is stopped'
    callback()

  restart: ->
    if @_started
      @stop () =>
        @start()
    else
      @start()

module.exports = new Octavius()