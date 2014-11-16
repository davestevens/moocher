require [
  "marionette",
  "backbone",
  "bootstrap",
  "app/routers/connections_router",
  "app/routers/requests_router",
  "backbone.dualStorage"
], (Marionette, Backbone, Bootstrap, ConnectionsRouter, RequestsRouter) ->
  App = new Marionette.Application()

  App.addInitializer(->
    new ConnectionsRouter()
    new RequestsRouter()
  )

  App.addInitializer(-> Backbone.history.start())

  App.start()
