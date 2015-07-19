colors = require('colors')
global.browserSync = require 'browser-sync'

unless skipBuild
  server = browserSync
    xip: true
    open: 'external'
    browser: 'google chrome'
    server:
      baseDir: './public'

  process.on 'uncaughtException', (err) ->
    switch err.code
      when 'EADDRINUSE'
        console.log "Error: another copy of Gulpify is running now. Please shut down all other instances and try again.".red
        process.exit code=0

  gulp.task 'livereload', () ->
    browserSync.reload()