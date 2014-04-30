{getBrowser} = require 'testium'
assert = require 'assertive'

describe 'App', ->
  before ->
    @browser = getBrowser()

  it 'loads', ->
    @browser.navigateTo '/'
    @browser.assert.httpStatus 200

