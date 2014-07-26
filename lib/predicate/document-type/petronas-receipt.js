var DatePatterns, dateParser, extractPatternFromDateParserFn;

dateParser = require('../../predicate/date-parser');

DatePatterns = dateParser.Patterns;

extractPatternFromDateParserFn = dateParser.extractPatternFromDateParserFn;

module.exports = {
  documentTypeName: function() {
    return 'Petronas Receipt';
  },
  targetDir: function() {
    return 'receipts/petronas/';
  },
  matches: function(value) {
    return value.match(/petronas/gi);
  },
  extractPattern: function(noSpaceContent) {
    return extractPatternFromDateParserFn((function() {
      return dateParser.matchAny(noSpaceContent, DatePatterns['DD-MM-YYYY'], DatePatterns['DD-MM-YY']);
    }), this.documentTypeName());
  }
};
