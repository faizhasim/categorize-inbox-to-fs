glob = require 'glob'
tika = require 'tika'
gutil = require 'gulp-util'
Lazy = require 'lazy.js'

documentType = require './predicate/document-type'
filesort = require './filesort'

processDocument = (filename, matchPattern, receiptDir) ->
  fileExtensionRegex = /\.[^/.]+$/ # .pdf
  fileNameRegex = /(\w|[ \-.$?=~!@$%^&*()]*)+$/ # this-isa_file$name

  currentWorkDirectory = (filename.replace fileExtensionRegex, "").replace(fileNameRegex, "")
  truncatedFilename = (filename.replace fileExtensionRegex, "").substring currentWorkDirectory.length

  return if not matchPattern

  src = currentWorkDirectory + truncatedFilename + ".pdf"
  dest = currentWorkDirectory + receiptDir

  filesort.moveFileAccordingToPattern src, dest, matchPattern

module.exports.extract = (src, opts) ->
  glob src, opts, (err, files) -> files.forEach (filename) ->

    tika.extract filename, (err, text) ->
      return if err

      noSpaceContent = text.replace /\s+/g, ''
      matchAlreadyFound = false
      runnable = (docTypeKey) ->
        return if matchAlreadyFound
        if documentType[docTypeKey].matches noSpaceContent
          processDocument filename, (documentType[docTypeKey].extractPattern noSpaceContent), documentType[docTypeKey].targetDir()
          gutil.log (gutil.colors.green "#{documentType[docTypeKey].documentTypeName()}: ") + filename
          matchAlreadyFound = true

      (Lazy documentType).keys().each runnable

      gutil.log (gutil.colors.red 'Unknown Document Type: ') + filename unless matchAlreadyFound



