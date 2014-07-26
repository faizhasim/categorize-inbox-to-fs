dateParser = require '../../predicate/date-parser'
DatePatterns = dateParser.Patterns
extractPatternFromDateParserFn = dateParser.extractPatternFromDateParserFn

module.exports =
  documentTypeName: -> 'Petronas Receipt'

  targetDir: -> 'receipts/petronas/'

  matches: (value) -> value.match /petronas/gi

  extractPattern: (noSpaceContent) ->
    extractPatternFromDateParserFn (->
      dateParser.matchAny noSpaceContent, DatePatterns['DD-MM-YYYY'], DatePatterns['DD-MM-YY']
    ), @documentTypeName()
