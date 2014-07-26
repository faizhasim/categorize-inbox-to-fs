dateParser = require '../../src/predicate/date-parser'
chai = require 'chai'
expect = chai.expect


describe 'date-parser', ->
  describe 'DD-MM-YYYY', ->
    it 'should able to parse 10-01-2014', ->
    it 'should able to parse 10-D1-2014', ->
    it 'should able to parse i0-D1-2014', ->
    it 'should able to parse l0-D1-2014', ->
    it 'should able to parse 10-D1-201A', ->
    it 'should not able to parse 10-13-2013', ->
    it 'should not able to parse 31-01-2013', ->
    it 'should not able to parse 10-01-20', ->

