gulp = require 'gulp'
mocha = require 'gulp-mocha'

module.exports = (options) ->
  after: ['test-scripts']
  run: ->
    gulp
      .src('./test/tmp/unit-bundle.js', {read: false})
      .pipe(mocha( reporter: 'spec' ))

