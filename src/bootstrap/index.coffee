View = require '~/entity/view'
Model = require '~/entity/model'

setTimeout (->
  # jquery on npm still registers a global
  delete window.$
), 0

model = new Model 'some', 'guy'
view = new View model

console.log view.present()

