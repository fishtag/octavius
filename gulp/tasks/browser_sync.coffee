global.browserSync = require 'browser-sync'
browserSync
  xip: true
  reloadOnRestart: false
  browser: "google chrome"
  server:
    baseDir: './public'

gulp.task 'livereload', () ->
  browserSync.reload()