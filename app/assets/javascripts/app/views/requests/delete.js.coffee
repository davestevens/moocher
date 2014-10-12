define [
  "marionette",
  "text!app/templates/requests/delete.html"
], (Marionette, Template) ->
  class RequestsDeleteView extends Marionette.ItemView
    template: _.template(Template)

    events:
      "click #js-delete": "_delete"
      "click #js-cancel": "_cancel"

    _delete: ->
      @model.destroy()
      window.location.hash = "##{@route}"

    _cancel: ->
      window.location.hash = "##{@route}/#{@model.id}"

    route: "requests"
