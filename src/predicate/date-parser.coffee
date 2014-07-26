moment = require 'moment'
Lazy = require 'lazy.js'

parseDate = (value, regex, format) ->
  value = value
    .replace /D/g, '0'
    .replace /i/g, '1'
    .replace /l/g, '1'
    .replace /A/g, '4'
    .replace /\^/g, '/'
  regexMatch = value.match regex
  if regexMatch
    momentObject = moment regexMatch[0], format
    return (momentObject.format 'YYYY-MM-DD')

  return undefined

matchDateType = (type, regex) ->
  (parseDate value, new RegExp(regex, 'g'), type)

Patterns =
  'DD-MM-YYYY': (value) -> (parseDate value, new RegExp('[0-9]{2}\/[0-9]{2}\/[0-9]{4}', 'g'), 'DD-MM-YYYY')
  'DD-MM-YY': (value) -> (parseDate value, new RegExp('[0-9]{2}\/[0-9]{2}\/[0-9]{2}', 'g'), 'DD-MM-YY')

module.exports.Patterns = Patterns

module.exports.matchAny = (value, types...) ->
  execute = (fn) ->
    return fn value
  reduceAny = (x, y) ->  x || y

  types.push -> false

  matchedDate = (Lazy types)
    .map execute
    .reduce reduceAny

  matchedDate

module.exports.extractPatternFromDateParserFn = (fn, suffix) ->
  pattern = fn()
  if pattern
    return "#{pattern} #{suffix}"
  else
    return "~ #{(moment new Date()).format 'YYYY-MM-DD'} #{suffix}"