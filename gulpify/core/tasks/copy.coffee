Task = require "#{__base}/core/task"

class CopyTask extends Task
  _paths:
    destination: ''
  _fileMask: '*.*'

  develop: ->
    gulp.src @paths().source + '**/*.*'
      .pipe gulp.dest @paths().destination

module.exports = CopyTask