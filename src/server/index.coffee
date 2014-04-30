createServer = require './server'

server = createServer().listen 7000, ->
  port = server.address().port
  console.log "Listening on port: #{port}"

