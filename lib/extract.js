var Lazy, documentType, filesort, glob, gutil, processDocument, tika;

glob = require('glob');

tika = require('tika');

gutil = require('gulp-util');

Lazy = require('lazy.js');

documentType = require('./predicate/document-type');

filesort = require('./filesort');

processDocument = function(filename, matchPattern, receiptDir) {
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
        var matchAlreadyFound, noSpaceContent, runnable;
        if (err) {
          return;
        }
        noSpaceContent = text.replace(/\s+/g, '');
        matchAlreadyFound = false;
        runnable = function(docTypeKey) {
          if (matchAlreadyFound) {
            return;
          }
          if (documentType[docTypeKey].matches(noSpaceContent)) {
            processDocument(filename, documentType[docTypeKey].extractPattern(noSpaceContent), documentType[docTypeKey].targetDir());
            gutil.log((gutil.colors.green("" + (documentType[docTypeKey].documentTypeName()) + ": ")) + filename);
            return matchAlreadyFound = true;
          }
        };
        (Lazy(documentType)).keys().each(runnable);
        if (!matchAlreadyFound) {
          return gutil.log((gutil.colors.red('Unknown Document Type: ')) + filename);
        }
      });
    });
  });
};
