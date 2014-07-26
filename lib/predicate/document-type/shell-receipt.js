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
        return value.match(/b[0o][hn]u[s3][li][i1l]nk/gi);
      },
      fuelKeyword: function() {
        return value.match(/fuel/gi);
      },
      kualaPilahFuelCompany: function() {
        return value.match(/EB-ETENTERPRISE/gi);
      },
      kualaPilahAddressCompany: function() {
        return value.match(/KM1\.5.*MELANG/gi);
      },
      bonuslinkNumber: function() {
        return value.match(/6[0o][1il]884[0o]{3}7[0o]4[0o]974/gi);
      }
    };
    return matches(predicates);
  },
  extractPattern: function(noSpaceContent) {
    return extractPatternFromDateParserFn((function() {
      return dateParser.matchAny(noSpaceContent, DatePatterns['DD-MM-YYYY'], DatePatterns['DD-MM-YY']);
    }), 'shell receipt');
  }
};
