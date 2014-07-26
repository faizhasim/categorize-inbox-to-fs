vinylFs = require 'vinyl-fs'
rename = require 'gulp-rename'
clean = require 'gulp-clean'

processedBaseNames = []

contains = (newBaseName) ->
  processedBaseNames.push newBaseName
  (processedBaseNames.indexOf newBaseName) isnt -1

counters = {}
getCounter = (newBaseName) ->
  if counters[newBaseName]?
    counters[newBaseName] = counters[newBaseName] + 1
  else
    counters[newBaseName] = 1
  counters[newBaseName]

module.exports.moveFileAccordingToPattern = (src, dest, newBaseName) ->
  if contains newBaseName
    newBaseName = newBaseName + ' #' + (getCounter newBaseName)
  vinylFs.src src
    .pipe clean force: true
    .pipe rename (path) ->
      if newBaseName
        path.basename = newBaseName
      return
    .pipe vinylFs.dest dest
