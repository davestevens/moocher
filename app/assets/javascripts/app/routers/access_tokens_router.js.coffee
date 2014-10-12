define [
  "marionette",
  "app/controllers/access_tokens_controller"
], (Marionette, AccessTokensController) ->
  class AccessTokensRouter extends Marionette.AppRouter
    initialize: ->
      @main = new Marionette.Region(el: ".main")
      @on("route", @change)

    change: -> @main.show(@controller.view)

    controller: AccessTokensController

    appRoutes:
      "access_tokens": "index"
      "access_tokens/new": "new"
      "access_tokens/:id": "show"
      "access_tokens/:id/edit": "edit"
