global.browserSync = require 'browser-sync'
console.log __dirname
browserSync
  xip: true
  open: "external"
  browser: "google chrome"
  server:
    baseDir: './public'

gulp.task 'livereload', () ->
  browserSync.reload()