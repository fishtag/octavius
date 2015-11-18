Task = require "#{__base}/core/task"
Path = require 'path'
Jade = require 'gulp-jade'
Data = require 'gulp-data'
Minify = require 'gulp-htmlmin'

class JadeTask extends Task
  _sources: ['json', 'mongodb']
  _paths:
    destination: '/'
  options:
    asset: false
    livereload: {}
    watch: global.__app+'/jade/**/*.jade'

  develop: ->
    gulp.src @paths().source + '/*.jade'
      .pipe Data (file, callback) =>
        filename = Path.basename(file.path, '.jade')
        @data filename, callback
      .on("error", Application::log.error)
      .pipe Jade()
        .on("error", Application::log.error)
      .pipe gulp.dest @paths().destination

  production: ->
    gulp.src @paths().source + '/*.jade'
      .pipe Jade()
        .on("error", Application::log.error)
      .pipe Minify
        collapseWhitespace: true
      .pipe gulp.dest @paths().destination

  data: (filename, callback) ->
    result = false
    _.each JadeTask::_sources, (source) =>
      path = "#{global.__app}/data/#{filename}.#{source}"
      result = @["_#{source}"] if fileExists(path)
    if result
      result filename, callback
    else
      {}

  _json: (filename, callback) ->
    callback undefined, require("#{global.__app}/data/#{filename}.json")

  _mongodb: (filename, callback) ->
    dataStructure = JSON.parse(fs.readFileSync("#{global.__app}/data/#{filename}.mongodb", 'utf8'))
    Radio.emit 'mongo:collections', {
      collections: dataStructure
      callback: callback
    }


module.exports = JadeTask