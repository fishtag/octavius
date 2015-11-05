path = "#{__base}/tasks"
tasks = Tasks.require(module, path)
console.log _.keys tasks
module.exports = tasks