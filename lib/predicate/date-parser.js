var Lazy, Patterns, matchDateType, moment, parseDate,
  __slice = [].slice;

moment = require('moment');

Lazy = require('lazy.js');

parseDate = function(value, regex, format) {
  var momentObject, regexMatch;
  value = value.replace(/D/g, '0').replace(/i/g, '1').replace(/l/g, '1').replace(/A/g, '4').replace(/\^/g, '/');
  regexMatch = value.match(regex);
  if (regexMatch) {
    momentObject = moment(regexMatch[0], format);
    return momentObject.format('YYYY-MM-DD');
  }
  return void 0;
};

matchDateType = function(type, regex) {
  return parseDate(value, new RegExp(regex, 'g'), type);
};

Patterns = {
  'DD-MM-YYYY': function(value) {
    return parseDate(value, new RegExp('[0-9]{2}\/[0-9]{2}\/[0-9]{4}', 'g'), 'DD-MM-YYYY');
  },
  'DD-MM-YY': function(value) {
    return parseDate(value, new RegExp('[0-9]{2}\/[0-9]{2}\/[0-9]{2}', 'g'), 'DD-MM-YY');
  }
};

module.exports.Patterns = Patterns;

module.exports.matchAny = function() {
  var execute, matchedDate, reduceAny, types, value;
  value = arguments[0], types = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
  execute = function(fn) {
    return fn(value);
  };
  reduceAny = function(x, y) {
    return x || y;
  };
  types.push(function() {
    return false;
  });
  matchedDate = (Lazy(types)).map(execute).reduce(reduceAny);
  return matchedDate;
};

module.exports.extractPatternFromDateParserFn = function(fn, suffix) {
  var pattern;
  pattern = fn();
  if (pattern) {
    return "" + pattern + " " + suffix;
  } else {
    return "~ " + ((moment(new Date())).format('YYYY-MM-DD')) + " " + suffix;
  }
};
