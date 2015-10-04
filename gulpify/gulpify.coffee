require './core/globals'

global.Gulpify = class Gulpify
  log: require './core/log'
  develop: true
  watch: true
  constructor: ->
    @tasks = new (require './core/tasks')()
    @services = new (require './core/services')()

    @_started = false

  start: ->
    Gulpify::log.info 'trying to start..'
    @_started = true
    @tasks.load().start()
    @services.load()
    Gulpify::log.info 'application is started!'

  stop: (callback) ->
    Gulpify::log.info 'trying to stop..'
    @_started = false
    Gulpify::log.info 'application is stopped'
    callback()

  restart: ->
    if @_started
      @stop () =>
        @start()
    else
      @start()

module.exports = new Gulpify()