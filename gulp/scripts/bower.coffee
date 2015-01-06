gulp = require 'gulp'
bower = require 'bower'

gulp.task "bower", (cb) ->
  bower.commands.install([],
    save: true
  , {}).on "end", (installed) ->
    cb() # notify gulp that this task is finished
    return

  return