dateParser = require '../../predicate/date-parser'
DatePatterns = dateParser.Patterns
extractPatternFromDateParserFn = dateParser.extractPatternFromDateParserFn
matches = (require '../utils').matches

module.exports =
  documentTypeName: -> 'Shell Receipt'

  targetDir: -> 'receipts/shell/'

  matches: (value) ->
    predicates =
      #shell
      shellKeyword : -> value.match /sh[e3]ll/gi

      #bonuslink
      bonuslinkKeyword : -> value.match /b[0o][hn]u[s3][li][i1l]n[kx]/gi

      #fuel
      fuelKeyword : -> value.match /fuel/gi

    matches predicates

  extractPattern: (noSpaceContent) ->
    extractPatternFromDateParserFn (->
      dateParser.matchAny noSpaceContent, DatePatterns['DD-MM-YYYY'], DatePatterns['DD-MM-YY']
    ), @documentTypeName()