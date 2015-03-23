config = global.config.deploy
colors = require('colors')

gulp.task 'deploy', () ->
  sequence 'rsync', 'rsync-success'

gulp.task 'rsync', () ->
  gulp.src(paths.public+'**/*')
  .pipe plugins.rsync config

gulp.task 'rsync-success', () ->
  console.log "Deploy: build succeeded for '#{config.root}' folder".green
  process.exit code=0


