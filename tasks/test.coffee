gulp = require 'gulp'
mocha = require 'gulp-mocha'

module.exports = (options) ->
  after: ['test-scripts']
  run: ->
    gulp
      .src('./test/tmp/unit-bundle.js', {buffer: false})
      .pipe(mocha( reporter: 'spec' ))

