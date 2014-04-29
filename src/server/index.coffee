express = require 'express'
app = express()

app.use '/assets', express.static("#{__dirname}/../../public")

app.get '/favicon.ico', (request, response) ->
  response.end()

app.get '/', (request, response) ->
  html = require('fs').readFileSync("#{__dirname}/index.html").toString()
  response.send(html)

server = app.listen 7000, ->
  port = server.address().port
  console.log "Listening on port: #{port}"

