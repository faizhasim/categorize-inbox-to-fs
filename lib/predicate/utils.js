module.exports.matches = function(predicates) {
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
