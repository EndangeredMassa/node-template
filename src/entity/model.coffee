module.exports = class EntityModel
  constructor: (@firstName, @lastName) ->

  fullName: ->
    "#{@firstName} #{@lastName}"

