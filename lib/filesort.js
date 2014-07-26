var clean, contains, counters, getCounter, processedBaseNames, rename, vinylFs;

vinylFs = require('vinyl-fs');

rename = require('gulp-rename');

clean = require('gulp-clean');

processedBaseNames = [];

contains = function(newBaseName) {
  processedBaseNames.push(newBaseName);
  return (processedBaseNames.indexOf(newBaseName)) !== -1;
};

counters = {};

getCounter = function(newBaseName) {
  if (counters[newBaseName] != null) {
    counters[newBaseName] = counters[newBaseName] + 1;
  } else {
    counters[newBaseName] = 1;
  }
  return counters[newBaseName];
};

module.exports.moveFileAccordingToPattern = function(src, dest, newBaseName) {
  if (contains(newBaseName)) {
    newBaseName = newBaseName + ' #' + (getCounter(newBaseName));
  }
  return vinylFs.src(src).pipe(clean({
    force: true
  })).pipe(rename(function(path) {
    if (newBaseName) {
      path.basename = newBaseName;
    }
  })).pipe(vinylFs.dest(dest));
};
