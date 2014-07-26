map = require 'vinyl-map'
vinylFs = require 'vinyl-fs'
receipt = require './predicate/receipt'

filesort = require './filesort'

glob = require 'glob'
tika = require 'tika'

gutil = require 'gulp-util'



processFuelReceipt = (filename, matchPattern, receiptDir) ->
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
      if receipt.shell.matches noSpaceContent
        processFuelReceipt filename, (receipt.shell.extractPattern noSpaceContent), 'receipts/shell/'
        gutil.log (gutil.colors.green 'Shell receipt: ') + filename
      else if receipt.petronas.matches noSpaceContent
        processFuelReceipt filename, (receipt.petronas.extractPattern noSpaceContent), 'receipts/petronas/'
        gutil.log (gutil.colors.green 'Petronas receipt: ') + filename
      else
        gutil.log (gutil.colors.red 'No match for: ') + filename

