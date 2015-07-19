localConfig = global.app.config.production
requireTree './gulp/tasks'

gulp.task 'production', () ->
  tasks = _.values localConfig.tasks
  tasks.push 'production-success'
  sequence.apply this, tasks

gulp.task 'production-success', () ->
  console.log "Production: build succeeded".green
  process.exit code=0