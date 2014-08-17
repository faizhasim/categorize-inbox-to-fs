var DatePatterns, dateParser, extractPatternFromDateParserFn, matches;

dateParser = require('../../predicate/date-parser');

DatePatterns = dateParser.Patterns;

extractPatternFromDateParserFn = dateParser.extractPatternFromDateParserFn;

matches = (require('../utils')).matches;

module.exports = {
  documentTypeName: function() {
    return 'Shell Receipt';
  },
  targetDir: function() {
    return 'receipts/shell/';
  },
  matches: function(value) {
    var predicates;
    predicates = {
      shellKeyword: function() {
        return value.match(/sh[e3]ll/gi);
      },
      bonuslinkKeyword: function() {
        return value.match(/b[0o][hn]u[s3][li][i1l]n[kx]/gi);
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
    }), this.documentTypeName());
  }
};
