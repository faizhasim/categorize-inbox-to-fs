var DatePatterns, dateParser, extractPatternFromDateParserFn, matches, moment;

dateParser = require('../predicate/date-parser');

DatePatterns = dateParser.Patterns;

moment = require('moment');

matches = function(predicates) {
  var isMatch, predicate, type;
  for (type in predicates) {
    predicate = predicates[type];
    isMatch = predicate();
    if (isMatch) {
      return isMatch;
    }
  }
  return null;
};

extractPatternFromDateParserFn = function(fn, suffix) {
  var pattern;
  pattern = fn();
  if (pattern) {
    return "" + pattern + " " + suffix;
  } else {
    return "~ " + ((moment(new Date())).format('YYYY-MM-DD')) + " " + suffix;
  }
};

module.exports = {
  shell: {
    matches: function(value) {
      var predicates;
      predicates = {
        shellKeyword: function() {
          return value.match(/sh[e3]ll/gi);
        },
        bonuslinkKeyword: function() {
          return value.match(/b[0o][hn]u[s3][li][i1l]nk/gi);
        },
        fuelKeyword: function() {
          return value.match(/fuel/gi);
        }
      };
      return matches(predicates);
    },
    extractPattern: function(noSpaceContent) {
      return extractPatternFromDateParserFn((function() {
        return dateParser.matchAny(noSpaceContent, DatePatterns['DD-MM-YYYY'], DatePatterns['DD-MM-YY']);
      }), 'shell receipt');
    }
  },
  petronas: {
    matches: function(value) {
      return value.match(/petronas/gi);
    },
    extractPattern: function(noSpaceContent) {
      return extractPatternFromDateParserFn((function() {
        return dateParser.matchAny(noSpaceContent, DatePatterns['DD-MM-YYYY'], DatePatterns['DD-MM-YY']);
      }), 'petronas receipt');
    }
  }
};
