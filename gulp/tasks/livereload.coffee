class Livereload
  constructor: (config) ->
    @config = config
    @config.express_root = __dirname;
    console.log 'Starting livereload server..'.green
    @startExpress()
    @startLivereload()
    console.log "Livereload server is listening port:".green, "#{@config.livereload_port}".white

  startExpress: () ->
    @express = require 'express'
    @app = @express()
    @app.use require 'connect-livereload'
    @app.use @express.static @config.express_root
    @app.listen @config.express_port

  startLivereload: () ->
    @livereload = require('tiny-lr')()
    @livereload.listen @config.livereload_port

  notifyLivereload: () ->
    @livereload.changed body: {
      files: '/app'
    }

  changeEvent: () ->
    @notifyLivereload()

# Register global livereload object
global.livereload = new Livereload config.livereload

gulp.task 'livereload', () ->
  livereload.changeEvent()