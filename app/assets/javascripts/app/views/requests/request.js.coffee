define [
  "marionette",
  "text!app/templates/requests/request.html"
], (Marionette, Template) ->
  class RequestView extends Marionette.ItemView
    tagName: "a"

    className: "list-group-item"

    template: _.template(Template)

    attributes: =>
      href: "#requests/#{@model.id}"
