Sequence = require 'run-sequence'
Task = require "#{__base}/core/task"
Jade = require 'gulp-jade'
Minify = require 'gulp-htmlmin'

class BowerTask extends Task
  _paths:
    destination: '/'
  options:
    dependencies: ['bower:install', 'bower:clean', 'bower:files']
    asset: false
    livereload: {}
    watch: global.__bower

  develop: ->
    Application::log.info 'Bower sequence is completed'

module.exports = {
  task: BowerTask
  subtasks: Tasks.require(module, "#{__base}/tasks/bower")
}