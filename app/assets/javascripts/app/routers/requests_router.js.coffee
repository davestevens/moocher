define [
  "marionette",
  "app/controllers/requests_controller"
], (Marionette, RequestsController) ->
  class RequestsRouter extends Marionette.AppRouter
    initialize: ->
      @main = new Marionette.Region(el: ".main")
      @on("route", @change)

    change: -> @main.show(@controller.view)

    controller: RequestsController

    appRoutes:
      "requests": "index"
      "requests/new": "new"
      "requests/:id": "show"
      "requests/:id/delete": "delete"
