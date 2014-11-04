define [
  "marionette",
  "text!app/templates/connections/connection.html"
], (Marionette, Template) ->
  class ConnectionView extends Marionette.ItemView
    tagName: "a"

    className: "list-group-item"

    template: _.template(Template)

    attributes: =>
      href: "#connections/#{@model.id}"