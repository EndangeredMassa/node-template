gulp = require 'gulp'
watchify = require 'watchify'

{makeDefaultBundler} = require './scripts'

DELAY = 600

module.exports = (options, digest) ->
  after: [ 'styles' ]
  run: ->
    lastError = null

    # This will magically watch and do incremental builds
    tryBundling = ->
      bundler = null

      retryOnError = (err) ->
        unless lastError? && err.toString() == lastError.toString()
          lastError = err
          console.error err.toString()
        bundler.removeListener('update', bundler.rebundle)
        setTimeout tryBundling, DELAY

      bundler = makeDefaultBundler(options, digest, watchify, retryOnError)
      bundler.on('update', bundler.rebundle)
      bundler.rebundle()

    tryBundling()

