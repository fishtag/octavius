readline = require('readline')
argv = require('optimist').argv
blockName = argv.name

createBlock = (blockName) ->
  sequence 'block-slim', 'block-style', () ->
    console.log 'Block is successful created!'.green

gulp.task 'block-slim', () ->
  gulp.src app.config.slim.template
    .pipe plugins.consolidate 'lodash', {
      blockName: blockName
    }
    .pipe plugins.rename "#{blockName}.slim"
    .pipe gulp.dest app.config.slim.target

  fs.appendFileSync app.config.slim.include, """

    '
      include include/#{blockName}
    """

gulp.task 'block-style', () ->
  gulp.src app.config.styles.template
    .pipe plugins.consolidate 'lodash', {
      blockName: blockName
    }
    .pipe plugins.rename "_#{blockName}.scss"
    .pipe gulp.dest app.config.styles.target
  fs.appendFileSync app.config.styles.include, """

  @import "includes/#{blockName}";
"""

gulp.task 'block', () ->
  rl = readline.createInterface {
    input: process.stdin
    output: process.stdout
  }

  unless blockName
    console.log 'Block name is not correct. Use --name=%blockname% to generate new block'.red
    process.exit code=0

  rl.question "Create new block with name '#{blockName}'? [Y/n] ".green, (answer) ->
    if answer == 'Y'
      console.log 'yes!'
      createBlock blockName

    rl.close()

