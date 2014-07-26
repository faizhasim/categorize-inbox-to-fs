var filesort, glob, gutil, map, processFuelReceipt, receipt, tika, vinylFs;

map = require('vinyl-map');

vinylFs = require('vinyl-fs');

receipt = require('./predicate/receipt');

filesort = require('./filesort');

glob = require('glob');

tika = require('tika');

gutil = require('gulp-util');

processFuelReceipt = function(filename, matchPattern, receiptDir) {
  var currentWorkDirectory, dest, fileExtensionRegex, fileNameRegex, src, truncatedFilename;
  fileExtensionRegex = /\.[^/.]+$/;
  fileNameRegex = /(\w|[ \-.$?=~!@$%^&*()]*)+$/;
  currentWorkDirectory = (filename.replace(fileExtensionRegex, "")).replace(fileNameRegex, "");
  truncatedFilename = (filename.replace(fileExtensionRegex, "")).substring(currentWorkDirectory.length);
  if (!matchPattern) {
    return;
  }
  src = currentWorkDirectory + truncatedFilename + ".pdf";
  dest = currentWorkDirectory + receiptDir;
  return filesort.moveFileAccordingToPattern(src, dest, matchPattern);
};

module.exports.extract = function(src, opts) {
  return glob(src, opts, function(err, files) {
    return files.forEach(function(filename) {
      return tika.extract(filename, function(err, text) {
        var noSpaceContent;
        if (err) {
          return;
        }
        noSpaceContent = text.replace(/\s+/g, '');
        if (receipt.shell.matches(noSpaceContent)) {
          processFuelReceipt(filename, receipt.shell.extractPattern(noSpaceContent), 'receipts/shell/');
          return gutil.log((gutil.colors.green('Shell receipt: ')) + filename);
        } else if (receipt.petronas.matches(noSpaceContent)) {
          processFuelReceipt(filename, receipt.petronas.extractPattern(noSpaceContent), 'receipts/petronas/');
          return gutil.log((gutil.colors.green('Petronas receipt: ')) + filename);
        } else {
          return gutil.log((gutil.colors.red('No match for: ')) + filename);
        }
      });
    });
  });
};
