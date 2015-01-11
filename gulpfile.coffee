require './gulp/utils'

global.yaml       = require 'node-yaml-config'
global.config     = yaml.load './gulp/config.yml'
global.gulp       = require 'gulp'
global.sequence   = require 'run-sequence'
global._          = require 'underscore'
global.paths      = require './gulp/config/paths'
global.plugins    = require('gulp-load-plugins')({
  pattern: ['gulp-*', 'gulp.*']
  replaceString: /\bgulp[\-.]/
})

requireTree './gulp/scripts'

gulp.task 'start', () ->
  sequence 'bower', 'bower-packages', () ->
    requireTree './gulp/tasks'

# Start default Gulp Task
gulp.task 'default', ['start']