requireDirectory = require 'require-directory'
class Tasks
  options:
    tasks: "#{__base}/tasks"

  constructor: (options = {}) ->
    @options = _.extend Tasks::options, options
    @tasks = {}

  load: (path = @options.tasks) ->
    _.each requireDirectory(module, path), (taskClass, name) =>
      @tasks[name] = new taskClass(name)
    @

  start: ->
    _.each @tasks, (task, name) =>
      task.start()

module.exports = Tasks