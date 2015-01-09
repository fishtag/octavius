require './gulp/utils'

global.config     = require './gulp/config.json'
global.gulp       = require 'gulp'
global.sourcemaps = require 'gulp-sourcemaps'
global.sequence   = require 'run-sequence'
global._          = require 'underscore'
global.fs         = require 'fs'
global.paths      = require './gulp/config/paths'
global.plugins    = require('gulp-load-plugins')({
  pattern: ['gulp-*', 'gulp.*']
  replaceString: /\bgulp[\-.]/
})

requireTree ['./gulp/scripts', './gulp/tasks']

gulp.task 'init', () ->
  sequence 'bower', 'bower-packages'

# Start default Gulp Task
gulp.task 'start', ['init']