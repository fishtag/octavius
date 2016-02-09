Task = require "#{__base}/core/task"
Jade = require 'gulp-jade'
Minify = require 'gulp-htmlmin'
through = require 'through2'

class BowerInstallTask extends Task
  _paths:
    destination: '/'
  options:
    asset: false
    livereload: false

  develop: ->
    return util.noop() unless fileExists(__bower)

    gulp.src(__bower)
      .pipe through.obj (file, enc, cb) ->
        Radio.emit 'bower:prune', () ->
          Radio.emit 'bower:install', (result) ->
            Application::log.info 'Bower files successful installed'
            cb null, file

module.exports = BowerInstallTask