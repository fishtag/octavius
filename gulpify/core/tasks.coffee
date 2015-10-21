class Tasks
  constructor: (options = {}) ->
    @options = _.extend Tasks::options, options
    @tasks = {}

  load: (path = "#{__base}/tasks") ->
    _.each require(path), (taskFile, name) =>
      unless taskFile.subtasks
        @tasks[name] = new taskFile(name)
      else
        _.each taskFile.subtasks, (subtaskClass, name) =>
          @tasks[name] = new subtaskClass(name)
        @tasks[name] = new (taskFile.task)(name)
    @

  start: ->
    _.each @tasks, (task, name) =>
      task.start()

module.exports = Tasks