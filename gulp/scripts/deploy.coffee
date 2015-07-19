localConfig = global.app.config.deploy
ftp    = require 'vinyl-ftp'
colors = require 'colors'
gutil = require 'gulp-util'

gulp.task 'deploy', () ->
  if argv.ftp
    sequence 'ftp', 'deploy-success'
  else
    sequence 'rsync', 'deploy-success'

gulp.task 'ftp', () ->
  _.extend localConfig.ftp, {log: gutil.log}
  connection = ftp.create localConfig.ftp

  gulp.src(paths.public+'**/*')
    .pipe connection.newer localConfig.ftp.remotePath
    .pipe connection.dest localConfig.ftp.remotePath

gulp.task 'rsync', () ->
  gulp.src(paths.public+'**/*')
  .pipe plugins.rsync localConfig.rsync

gulp.task 'deploy-success', () ->
  console.log "Deploy: build succeeded for '#{localConfig.rsync.root}' folder".green
  process.exit code=0


