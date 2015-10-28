CopyTask = require "#{__base}/core/tasks/copy"

class CssTask extends CopyTask
  _paths:
    destination: 'css'

module.exports = CssTask