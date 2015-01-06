gulp = require 'gulp'
scripts = require './gulp/scripts'
paths = require './gulp/config/paths'

gulp.task 'init', () ->
  gulp.start 'bower-packages'

# Start default Gulp Task
gulp.task 'default', ['init']