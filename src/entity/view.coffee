template = require './template'
facile = require 'facile'
$ = require 'jquery'

module.exports = class EntityView
  constructor: (@model)->

  present: ->
    facile(template, @model, $)

