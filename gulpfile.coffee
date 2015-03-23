require './gulp/utils'
argv = require('optimist').argv
isProduction = argv.production

global.production = if (isProduction) then true else false
global.yaml       = require 'node-yaml-config'
global.config     = yaml.load './gulp/config.yml'
global.gulp       = require 'gulp'
global.fs         = require 'fs'
global.sequence   = require 'run-sequence'
global._          = require 'underscore'
global.paths      = require './gulp/config/paths'
global.plugins    = require('gulp-load-plugins')({
  pattern: ['gulp-*', 'gulp.*']
  replaceString: /\bgulp[\-.]/
})

# Get project folder name for tunnel use
path = require('path')
config.dirname = _.last path.dirname(__filename).split(path.sep)

requireTree './gulp/scripts'

if production
  gulp.start 'production'

gulp.task 'start', () ->
  sequence 'bower', 'bower-packages', () ->
    requireTree './gulp/tasks'

# Start default Gulp Task
gulp.task 'default', ['start']