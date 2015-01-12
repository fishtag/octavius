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

    process.on 'uncaughtException', (err) ->
      if(err.errno == 'EADDRINUSE')
        console.log 'Another Gulpify instance with same ports is running!'.red
        console.log 'You can change express and livereload ports in ./gulp/config.yml'.gray
      else
        console.log(err)
      process.exit(1)


    @app.use require 'connect-livereload'
    @app.use @express.static @config.express_root
    @app.listen @config.express_port

  startLivereload: () ->
    @livereload = require('tiny-lr')()
    @livereload.on 'error', handleError
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