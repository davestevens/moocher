require [
  "marionette",
  "backbone",
  "bootstrap",
  "app/routers/routers",
  "backbone.dualStorage"
], (Marionette, Backbone, Bootstrap, Routers, BackboneDualStorage) ->
  App = new Marionette.Application()

  App.addInitializer(-> Backbone.history.start())

  App.start()
