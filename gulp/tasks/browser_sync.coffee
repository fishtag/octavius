global.browserSync = require 'browser-sync'

unless skipBuild
  browserSync
    xip: true
    tunnel: config.dirname
    open: 'external'
    browser: 'google chrome'
    server:
      baseDir: './public'

  gulp.task 'livereload', () ->
    browserSync.reload()