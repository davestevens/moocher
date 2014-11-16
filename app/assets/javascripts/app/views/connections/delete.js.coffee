define [
  "marionette",
  "text!app/templates/connections/delete.html"
], (Marionette, Template) ->
  class ConnectionsDeleteView extends Marionette.ItemView
    template: _.template(Template)

    events:
      "click #js-delete": "_delete"
      "click #js-cancel": "_cancel"

    _delete: ->
      @model.destroy()
      window.location.hash = "##{@route}"

    _cancel: ->
      window.location.hash = "##{@route}/#{@model.id}"

    route: "connections"
