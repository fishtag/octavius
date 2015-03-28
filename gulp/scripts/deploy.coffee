config = global.config.deploy
colors = require('colors')

gulp.task 'deploy', () ->
  if argv.ftp
    sequence 'ftp', 'deploy-success'
  else
    sequence 'rsync', 'deploy-success'

gulp.task 'ftp', () ->
  gulp.src(paths.public+'**/*')
  .pipe plugins.ftp config.ftp

gulp.task 'rsync', () ->
  gulp.src(paths.public+'**/*')
  .pipe plugins.rsync config.rsync

gulp.task 'deploy-success', () ->
  console.log "Deploy: build succeeded for '#{config.root}' folder".green
  process.exit code=0


