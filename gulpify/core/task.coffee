Sequence = require 'run-sequence'
Watch = require 'gulp-watch'

class Task
  _paths:
    source: ''
    destination: ''

  defaults:
    asset: true
    develop: false
    livereload: false

  constructor: (filename, options = {}) ->
    @filename = filename
    @options = _.extend {}, Task::defaults, @constructor::options, options
    @_buildSequence()
    @initialize() if @initialize

    gulp.task @filename, () => @task()

  start: ->
    @run()
    @watch() if @options.watch and Gulpify::watch

  run: ->
    Sequence.apply @, @sequence

  watch: ->
    Watch(@options.watch, () => @run())

  task: ->
    if @options.develop
      @_develop()
    else
      @_production()

  _develop: ->
    Gulpify::log.info "#{@filename} develop"
    @develop()

  _production: ->
    Gulpify::log.info "#{@filename} production"
    if @production
      @production()
    else
      @develop()

  _buildSequence: ->
    @sequence = [@filename]
    if @options.livereload
      @sequence.push () =>
        Radio.emit('browsersync:reload', @options.livereload)
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