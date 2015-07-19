require './gulp/utils'
global.argv = require('optimist').argv

isProduction = argv.production
isDeploy = argv.deploy

global.app = {}
global.skipBuild = if (isProduction or isDeploy) then true else false
global.yaml       = require 'node-yaml-config'
global.app.config     = yaml.load './gulp/config.yml'
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
app.config.dirname = _.last path.dirname(__filename).split(path.sep)

requireTree './gulp/scripts'

defaultTask = 'start'

if isProduction
  defaultTask = 'production'

if isDeploy
  defaultTask = 'deploy'

gulp.task 'start', () ->
  sequence 'bower', 'bower-packages', () ->
    requireTree './gulp/tasks'

# Start default Gulp Task
gulp.task 'default', [defaultTask]