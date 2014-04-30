gulp = require 'gulp'
createServer = require '../src/server/server'

module.exports = (options, digest) ->
  after: ['assets']
  run: (done) ->
    server = createServer().listen 7000, ->
      port = server.address().port
      console.log "Listening on port: #{port}"
      done()

