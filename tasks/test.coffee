gulp = require 'gulp'
mocha = require 'gulp-mocha'

module.exports = (options) ->
  after: ['test-unit', 'test-integration']
  run: ->

