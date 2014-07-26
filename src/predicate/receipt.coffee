dateParser = require '../predicate/date-parser'
DatePatterns = dateParser.Patterns
moment = require 'moment'

matches = (predicates) ->
  for type, predicate of predicates
    isMatch = predicate()
    return isMatch if isMatch
  return null

extractPatternFromDateParserFn = (fn, suffix) ->
  pattern = fn()
  if pattern
    return "#{pattern} #{suffix}"
  else
    return "~ #{(moment new Date()).format 'YYYY-MM-DD'} #{suffix}"

module.exports =

  shell:
    matches: (value) ->
      predicates =
        #shell
        shellKeyword : -> value.match /sh[e3]ll/gi

        #bonuslink
        bonuslinkKeyword : -> value.match /b[0o][hn]u[s3][li][i1l]nk/gi

        #fuel
        fuelKeyword : -> value.match /fuel/gi

      matches predicates

    extractPattern: (noSpaceContent) ->
      extractPatternFromDateParserFn (->
        dateParser.matchAny noSpaceContent, DatePatterns['DD-MM-YYYY'], DatePatterns['DD-MM-YY']
      ), 'shell receipt'


  petronas:
    matches: (value) ->
      value.match /petronas/gi

    extractPattern: (noSpaceContent) ->
      extractPatternFromDateParserFn (->
        dateParser.matchAny noSpaceContent, DatePatterns['DD-MM-YYYY'], DatePatterns['DD-MM-YY']
      ), 'petronas receipt'





