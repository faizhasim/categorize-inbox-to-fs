moment = require 'moment'
Lazy = require 'lazy.js'

parseFormatDate = (value, regex, format) ->
  regexMatches = value.match regex
  if regexMatches
    for regexMatch in regexMatches
      momentObject = moment regexMatch, format
      return (momentObject.format 'YYYY-MM-DD') if momentObject.isValid()
  return undefined

parseStringFormatDate = (value, regex, format) ->
  value = value
  .replace /MAC/g, 'MAR'
  .replace /MEI/g, 'MAY'
  .replace /OGO/g, 'AUG'
  .replace /OKT/g, 'OCT'
  .replace /DES/g, 'DEC'
  parseFormatDate value, regex, format

parseNumericalFormatDate = (value, regex, format) ->
  value = value
  .replace /D/g, '0'
  .replace /i/g, '1'
  .replace /l/g, '1'
  .replace /A/g, '4'
  .replace /\^/g, '/'
  parseFormatDate value, regex, format

matchDateType = (type, regex) ->
  (parseNumericalFormatDate value, new RegExp(regex, 'g'), type)

ddMMMYYYYRegex = new RegExp('[0-9]{2}(?:JAN|FEB|MAC|MAR|APR|MEI|MAY|JUN|JUL|OGO|AUG|SEP|OKT|AUC|NOV|DES|DEC)[0-9]{4}', 'gi')
ddMMMYYRegex = new RegExp('[0-9]{2}(?:JAN|FEB|MAC|MAR|APR|MEI|MAY|JUN|JUL|OGO|AUG|SEP|OKT|AUC|NOV|DES|DEC)[0-9]{2}', 'gi')
ddMMMYYYYRegex = new RegExp('[0-9]{2}(?:JAN|FEB|MAC|MAR|APR|MEI|MAY|JUN|JUL|OGO|AUG|SEP|OKT|AUC|NOV|DES|DEC)[0-9]{4}', 'gi')

Patterns =
  'YYYY-MM-DD': (value) -> (parseNumericalFormatDate value, new RegExp('[0-9]{4}\/[0-9]{2}\/[0-9]{2}', 'g'), 'YYYY-MM-DD')
  'DD-MM-YYYY': (value) -> (parseNumericalFormatDate value, new RegExp('[0-9]{2}\/[0-9]{2}\/[0-9]{4}', 'g'), 'DD-MM-YYYY')
  'DD-MM-YY': (value) -> (parseNumericalFormatDate value, new RegExp('[0-9]{2}\/[0-9]{2}\/[0-9]{2}', 'g'), 'DD-MM-YY')
  'DDMMMYYYY': (value) -> (parseStringFormatDate value, ddMMMYYYYRegex, 'DDMMMYYYY')
  'DDMMMYY': (value) -> (parseStringFormatDate value, ddMMMYYRegex, 'DDMMMYY')
  'DDMMMYYYY': (value) -> (parseStringFormatDate value, ddMMMYYYYRegex, 'DDMMMYYYY')
  'DDMMMMYYYY': (value) -> (parseStringFormatDate value, new RegExp('[0-9]{1,2}[A-z]+[0-9]{4}', 'g'), 'DDMMMMYYYY')

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
