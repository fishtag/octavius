global.browserSync = require 'browser-sync'

unless skipBuild
  browserSync
    xip: true
    open: 'external'
    browser: 'google chrome'
    server:
      baseDir: './public'

  gulp.task 'livereload', () ->
    browserSync.reload()