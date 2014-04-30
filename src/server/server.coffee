express = require 'express'
fs = require 'fs'

module.exports = ->
  app = express()

  app.use '/assets', express.static("#{__dirname}/../../public")

  app.get '/favicon.ico', (request, response) ->
    response.end()

  app.get '/', (request, response) ->
    fs.readFile "#{__dirname}/index.html", (error, html) ->
      html = html.toString()
      response.send(html)

  app

