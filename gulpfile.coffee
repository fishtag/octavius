gulp = require 'gulp'
scripts = require './gulp/scripts'
paths = require './gulp/config/paths'

console.log scripts

# Start default Gulp Task
gulp.task 'default', ['watch']