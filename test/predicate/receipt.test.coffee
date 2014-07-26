receipt = require '../../src/predicate/receipt'
chai = require 'chai'
expect = chai.expect

itShouldMatch = (value, receiptType = 'shell') ->
  it "should match given `#{value}`", -> (expect receipt[receiptType] value).to.be.ok

itShouldMatch = (value, receiptType = 'shell') ->
  it "should match given `#{value}`", -> (expect receipt[receiptType] value).to.be.ok

describe 'receipt', ->
  describe '#shell', ->
    itShouldMatch 'dsfshellsdf'
    itShouldMatch 'dsfsh3llsdf'
    itShouldMatch 'afbonuslinkasd'
    itShouldMatch 'b0hu3l1nk'
    itShouldMatch 'fuel'
    itShouldMatch 'fuel'

    it "should not match given `jkfnliguf liuvdfnbkxfj lorem petronas`", ->
      (expect receipt.shell 'jkfnliguf liuvdfnbkxfj lorem petronas').to.not.be.ok

  describe '#petronas', ->
    itShouldMatch 'petronas', receiptType='petronas'

    it "should not match given `shell bonuslink test dummy`", ->
      (expect receipt.petronas 'shell bonuslink test dummy').to.not.be.ok
