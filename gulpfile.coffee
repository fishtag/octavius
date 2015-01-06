require './gulp/utils'

global.gulp       = require 'gulp'
global.gutil      = require 'gulp-util'
global.es         = require 'event-stream'
global.sourcemaps = require 'gulp-sourcemaps'
global._          = require 'underscore'
global.fs         = require 'fs'
global.paths      = require './gulp/config/paths'
global.plugins    = require('gulp-load-plugins')({
  pattern: ['gulp-*', 'gulp.*']
  replaceString: /\bgulp[\-.]/
})

requireTree ['./gulp/scripts', './gulp/tasks']

gulp.task 'init', () ->
  gulp.start 'bower-packages'

# Start default Gulp Task
gulp.task 'default', ['init', 'htmlInclude']