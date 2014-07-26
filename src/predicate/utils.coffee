module.exports.matches = (predicates) ->
  for type, predicate of predicates
    isMatch = predicate()
    return isMatch if isMatch
  return null