var Lazy, Patterns, ddMMMYYRegex, ddMMMYYYYRegex, matchDateType, moment, parseFormatDate, parseNumericalFormatDate, parseStringFormatDate,
  __slice = [].slice;

moment = require('moment');

Lazy = require('lazy.js');

parseFormatDate = function(value, regex, format) {
  var momentObject, regexMatch, regexMatches, _i, _len;
  regexMatches = value.match(regex);
  if (regexMatches) {
    for (_i = 0, _len = regexMatches.length; _i < _len; _i++) {
      regexMatch = regexMatches[_i];
      momentObject = moment(regexMatch, format);
      if (momentObject.isValid()) {
        return momentObject.format('YYYY-MM-DD');
      }
    }
  }
  return void 0;
};

parseStringFormatDate = function(value, regex, format) {
  value = value.replace(/MAC/g, 'MAR').replace(/MEI/g, 'MAY').replace(/OGO/g, 'AUG').replace(/OKT/g, 'OCT').replace(/DES/g, 'DEC');
  return parseFormatDate(value, regex, format);
};

parseNumericalFormatDate = function(value, regex, format) {
  value = value.replace(/D/g, '0').replace(/i/g, '1').replace(/l/g, '1').replace(/A/g, '4').replace(/\^/g, '/');
  return parseFormatDate(value, regex, format);
};

matchDateType = function(type, regex) {
  return parseNumericalFormatDate(value, new RegExp(regex, 'g'), type);
};

ddMMMYYYYRegex = new RegExp('[0-9]{2}(?:JAN|FEB|MAC|MAR|APR|MEI|MAY|JUN|JUL|OGO|AUG|SEP|OKT|AUC|NOV|DES|DEC)[0-9]{4}', 'gi');

ddMMMYYRegex = new RegExp('[0-9]{2}(?:JAN|FEB|MAC|MAR|APR|MEI|MAY|JUN|JUL|OGO|AUG|SEP|OKT|AUC|NOV|DES|DEC)[0-9]{2}', 'gi');

ddMMMYYYYRegex = new RegExp('[0-9]{2}(?:JAN|FEB|MAC|MAR|APR|MEI|MAY|JUN|JUL|OGO|AUG|SEP|OKT|AUC|NOV|DES|DEC)[0-9]{4}', 'gi');

Patterns = {
  'YYYY-MM-DD': function(value) {
    return parseNumericalFormatDate(value, new RegExp('[0-9]{4}\/[0-9]{2}\/[0-9]{2}', 'g'), 'YYYY-MM-DD');
  },
  'DD-MM-YYYY': function(value) {
    return parseNumericalFormatDate(value, new RegExp('[0-9]{2}\/[0-9]{2}\/[0-9]{4}', 'g'), 'DD-MM-YYYY');
  },
  'DD-MM-YY': function(value) {
    return parseNumericalFormatDate(value, new RegExp('[0-9]{2}\/[0-9]{2}\/[0-9]{2}', 'g'), 'DD-MM-YY');
  },
  'DDMMMYYYY': function(value) {
    return parseStringFormatDate(value, ddMMMYYYYRegex, 'DDMMMYYYY');
  },
  'DDMMMYY': function(value) {
    return parseStringFormatDate(value, ddMMMYYRegex, 'DDMMMYY');
  },
  'DDMMMYYYY': function(value) {
    return parseStringFormatDate(value, ddMMMYYYYRegex, 'DDMMMYYYY');
  },
  'DDMMMMYYYY': function(value) {
    return parseStringFormatDate(value, new RegExp('[0-9]{1,2}[A-z]+[0-9]{4}', 'g'), 'DDMMMMYYYY');
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
