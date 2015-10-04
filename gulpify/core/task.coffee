Sequence = require 'run-sequence'
Watch = require 'gulp-watch'

class Task
  _paths:
    source: ''
    destination: ''

  defaults:
    asset: true
    develop: true
    livereload: false

  constructor: (filename, options = {})->
    @filename = filename
    @options = _.extend @constructor::defaults, @constructor::options, options
    @initialize() if @initialize

    _.bindAll @, '_develop', '_production'
    gulp.task @filename, @task()

  start: ->
    @run()
    @watch() if @options.watch and Gulpify::watch

  run: ->
    Sequence @filename, () =>
      Radio.emit('reload', @options.livereload) if @options.livereload

  watch: ->
    Watch @options.watch, () =>
      @run()

  task: ->
    if @options.develop
      @_develop
    else
      @_production

  _develop: ->
    Gulpify::log.info "#{@filename} develop"
    @develop()

  _production: ->
    Gulpify::log.info "#{@filename} production"
    if @production
      @production()
    else
      @develop()

  paths: () ->
    source = if @constructor::_paths.source then @constructor::_paths.source else @filename
    destination = if @constructor::_paths.destination then @constructor::_paths.destination else @filename
    assets = if @options.asset then 'assets/' else ''
    {
      source: "#{__app}/#{source}/"
      destination: "#{__public}/#{assets}#{destination}/"
    }

module.exports = Task