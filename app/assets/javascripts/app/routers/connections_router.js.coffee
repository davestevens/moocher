define [
  "marionette",
  "app/controllers/connections_controller"
], (Marionette, ConnectionsController) ->
  class ConnectionsRouter extends Marionette.AppRouter
    initialize: ->
      @main = new Marionette.Region(el: ".main")
      @on("route", @change)

    change: -> @main.show(@controller.view)

    controller: ConnectionsController

    appRoutes:
      "connections": "index"
      "connections/new": "new"
      "connections/:id": "show"
      "connections/:id/edit": "edit"
      "connections/:id/delete": "delete"
