# Require the packages
bower = require 'bower'
_Str = require 'underscore.string'

# Declare the paths and excluded libraries
app = '../..'
exclude = require("#{app}/gulp/config/exclude").files

# Task to install all packages from bower json
gulp.task "bower", (cb) ->
  bower.commands.install([],
    save: true
  , {}).on "end", (installed) ->
    cb() # notify gulp that this task is finished
    return

  return

# Task to concat all main files of bower packages to one libraries.js
gulp.task 'bower-packages', ['bower'], () ->
  bowerFile = require "#{app}/bower.json"
  bowerPackages = bowerFile.dependencies
  bowerDir = "#{app}/bower_components"
  packagesOrder = []
  mainFiles = []

  # Function that check current package and add it to packagesOrder array
  addPackage = (name) ->
    info = require "#{bowerDir}/#{name}/bower.json"
    dependencies = info.dependencies

    # Check all dependencies of current package
    if !!dependencies
      _.each dependencies, (value, key) ->
        addPackage key if exclude.indexOf(key) == -1

    packagesOrder.push name if packagesOrder.indexOf(name) == -1

  _.each bowerPackages, (value, key) ->
    if exclude.indexOf(key) == -1
      addPackage key

  _.each packagesOrder, (bowerPackage) ->
    info = require "#{bowerDir}/#{bowerPackage}/bower.json"
    main = info.main
    mainFile = main

    if _.isArray main
      _.each main, (file) ->
        if _Str.endsWith file, '.js'
          mainFile = file

    mainFile = "#{paths.bower}/#{bowerPackage}/#{mainFile}"
    if _Str.endsWith mainFile, '.js'
      mainFiles.push mainFile

  destination = "#{app}/#{paths.scripts.dest}"
  gulp.src mainFiles
    .pipe plugins.concat 'libraries.js'
    .pipe gulp.dest "#{paths.assets}/js"