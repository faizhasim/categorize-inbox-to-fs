var argv = require('yargs').argv;
var gutil = require('gulp-util');
var extractor = require('./lib/extract');

var doesntContainsSrc = function() {
  if (!argv.src) {
    gutil.log(gutil.colors.red('Please specify --src=path/to/scanned/doc/*.pdf'));
  }
  return !argv.src
}

if (!doesntContainsSrc()) {
  extractor.extract(argv.src)
}
