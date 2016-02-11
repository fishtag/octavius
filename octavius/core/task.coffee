Sequence = require 'run-sequence'
Watch = require 'gulp-watch'

class Task
  _paths:
    source: ''
    destination: ''

  defaults:
    asset: true
    livereload: false

  constructor: (filename, options = {}) ->
    @filename = filename
    @options = _.extend {}, Task::defaults, @constructor::options, options
    @_buildSequence()
    @initialize() if @initialize

    gulp.task @filename, () => @task()

  start: ->
    @run() unless @_isSubtask() # Do not run at startup if it is dependency of another task
    if @options.watch and Application::watch
      @watch()

  run: ->
    Sequence.apply @, @sequence

  watch: ->
    Watch(@options.watch, () => @run())

  task: ->
    Application::log.info "#{@filename} started"
    if Application::develop
      @_develop()
    else
      @_production()

  _config: (production = false) ->
    return {} unless Config[@filename]
    baseConfig = Config[@filename]
    config = {}

    if baseConfig['develop'] or baseConfig['production']
      config['develop'] = baseConfig['develop'] || {}
      config['production'] = baseConfig['production'] || config['develop']
    else
      config['develop'] = config['production'] = baseConfig

    if production then config['production'] else config['develop']


  _develop: ->
    @develop()

  _production: ->
    if @production
      @production()
    else
      @develop()

  _isSubtask: ->
    (not _.isNull @filename.match /(\:)/)

  _buildSequence: ->
    @sequence = [@filename]
    if @options.livereload and Application::develop
      @sequence.push (arg) =>
        Radio.emit('browsersync:reload', {options: @options.livereload})
    if @options.dependencies
      @sequence = _.union @options.dependencies, @sequence

  paths: () ->
    source = if @constructor::_paths.source then @constructor::_paths.source else @filename
    destination = if @constructor::_paths.destination then @constructor::_paths.destination else @filename
    assets = if @options.asset then 'assets/' else ''
    {
      source: "#{__app}/#{source}/"
      destination: "#{__public}/#{assets}#{destination}/"
    }

module.exports = Task