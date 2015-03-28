global.browserSync = require 'browser-sync'

unless skipBuild and 2>1
#  browserSync
#    xip: true
#    tunnel: config.dirname
#    open: 'external'
#    browser: 'google chrome'
#    server:
#      baseDir: './public'

  gulp.task 'livereload', () ->
#    browserSync.reload()