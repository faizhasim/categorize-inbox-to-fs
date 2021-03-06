documentType = require '../../src/predicate/document-type'
chai = require 'chai'
expect = chai.expect

itShouldMatch = (value, receiptType = 'shell') ->
  console.log 'documentType[receiptType].matches value', documentType[receiptType].matches value
  it "should match given `#{value}`", -> (expect documentType[receiptType].matches value).to.be.ok

describe 'receipt', ->
  describe '#shell', ->
    itShouldMatch 'dsfshellsdf'
    itShouldMatch 'dsfsh3llsdf'
    itShouldMatch 'afbonuslinkasd'
    itShouldMatch 'b0hu3l1nk'
    itShouldMatch 'fuel'
    itShouldMatch 'fuel'

    it "should not match given `jkfnliguf liuvdfnbkxfj lorem petronas`", ->
      console.log 'asd', documentType.shell.matches 'jkfnliguf liuvdfnbkxfj lorem petronas'
      (expect documentType.shell.matches 'jkfnliguf liuvdfnbkxfj lorem petronas').to.not.be.ok

  describe '#petronas', ->
    itShouldMatch 'petronas', receiptType='petronas'

    it "should not match given `shell bonuslink test dummy`", ->
      (expect documentType.petronas.matches 'shell bonuslink test dummy').to.not.be.ok
