global.browserSync = require 'browser-sync'

browserSync
  xip: true
  tunnel: config.dirname
  open: 'tunnel'
  browser: 'google chrome'
  server:
    baseDir: './public'

gulp.task 'livereload', () ->
  browserSync.reload()