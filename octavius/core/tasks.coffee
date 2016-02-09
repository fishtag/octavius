Sequence = require 'run-sequence'

class global.Tasks
  @override: process.cwd()+'/octavius/tasks'
  @rename: (filename, joined, filename2) ->
    path = joined.split('octavius/tasks/')[1]
    .replace '/',':'
    .replace '.coffee',''
    path

  @require: (module, path) ->
    octaviusTasks = requireDirectory module, path, {
      rename: Tasks.rename
    }

    overrideTasks = if fileExists(@override)
      requireDirectory module, Tasks.override, {
        rename: Tasks.rename
      }
    else
      {}

    _.extend octaviusTasks, overrideTasks

  constructor: (options = {}) ->
    @options = _.extend Tasks::options, options
    @tasks = {}

  load: (path = "#{__base}/tasks") ->
    tasks = require(path)
    _.each tasks, (taskFile, name) =>
      unless taskFile.subtasks
        @tasks[name] = new taskFile(name)
      else
        _.each taskFile.subtasks, (subtaskClass, name) =>
          @tasks[name] = new subtaskClass(name)
        @tasks[name] = new (taskFile.task)(name)
    @

  start: (callback = false) ->
    if Application::develop
      _.each @tasks, (task, name) =>
        task.start()
    else
      sequence = []
      _.each @tasks, (task, name) =>
        sequence = _.union sequence, task.sequence

      console.log sequence
      Sequence.apply @, sequence, () =>
        console.log 'tasks callback'
        callback() if callback

module.exports = Tasks