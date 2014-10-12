define [
  "marionette",
  "text!app/templates/access_tokens/delete.html"
], (Marionette, Template) ->
  class AccessTokensDeleteView extends Marionette.ItemView
    template: _.template(Template)

    events:
      "click #js-delete": "_delete"
      "click #js-cancel": "_cancel"

    _delete: ->
      @model.destroy()
      window.location.hash = "##{@route}"

    _cancel: ->
      window.location.hash = "##{@route}/#{@model.id}"

    route: "access_tokens"
