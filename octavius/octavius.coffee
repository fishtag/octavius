require './core/globals'
ncp = require('ncp').ncp

global.Application = class Octavius
  log: require './core/log'
  develop: global.__develop
  watch: true

  constructor: ->
    @_init()
    @tasks = new (require './core/tasks')()
    @services = new (require './core/services')()
    @_started = false

  _init: ->
    return if fileExists(__app)

    Application::log.info 'Creating dummy application..'
    ncp "#{__dirname}/init/app", process.cwd() + '/app', (err) ->
      return Application::log.error(err) if err

      Application::log.info 'Dummy application successful created!'

  start: ->
    Application::log.info "Start application in #{ if Application::develop then 'develop' else 'production' } mode"
    @_started = true
    @services.load () =>
      @webserver = new (require './core/web')(@services)
      @tasks.load().start()
      Application::log.info 'application is started!'

  stop: (callback) ->
    Application::log.info 'trying to stop..'
    @_started = false
    Application::log.info 'application is stopped'
    callback()

  restart: ->
    if @_started
      @stop () =>
        @start()
    else
      @start()

module.exports = new Octavius()