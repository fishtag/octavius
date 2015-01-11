readline = require('readline')
argv = require('optimist').argv
blockName = argv.name
config = global.config.block

createBlock = (blockName) ->
  sequence 'block-slim', 'block-style', () ->
    console.log 'Block is successful created!'.green
    process.exit code=0

gulp.task 'block-slim', () ->
  gulp.src config.slim.template
    .pipe plugins.consolidate 'lodash', {
      blockName: blockName
    }
    .pipe plugins.rename "#{blockName}.slim"
    .pipe gulp.dest config.slim.target

  fs.appendFileSync config.slim.include, """

    '
      ##include('include/#{blockName}.html')
    """

gulp.task 'block-style', () ->
  gulp.src config.styles.template
    .pipe plugins.consolidate 'lodash', {
      blockName: blockName
    }
    .pipe plugins.rename "_#{blockName}.scss"
    .pipe gulp.dest config.styles.target
  fs.appendFileSync config.styles.include, """

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

