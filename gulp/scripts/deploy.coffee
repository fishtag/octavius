config = global.config.deploy
ftp    = require 'vinyl-ftp'
colors = require 'colors'
gutil = require 'gulp-util'

gulp.task 'deploy', () ->
  if argv.ftp
    sequence 'ftp', 'deploy-success'
  else
    sequence 'rsync', 'deploy-success'

gulp.task 'ftp', () ->
  _.extend config.ftp, {log: gutil.log}
  connection = ftp.create config.ftp

  gulp.src(paths.public+'**/*')
    .pipe connection.newer config.ftp.remotePath
    .pipe connection.dest config.ftp.remotePath

gulp.task 'rsync', () ->
  gulp.src(paths.public+'**/*')
  .pipe plugins.rsync config.rsync

gulp.task 'deploy-success', () ->
  console.log "Deploy: build succeeded for '#{config.rsync.root}' folder".green
  process.exit code=0


