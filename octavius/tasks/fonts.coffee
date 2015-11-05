CopyTask = require "#{__base}/core/tasks/copy"

class FontsTask extends CopyTask
  _paths:
    destination: 'fonts'

module.exports = FontsTask