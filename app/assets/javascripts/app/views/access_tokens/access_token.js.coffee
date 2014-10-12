define [
  "marionette",
  "text!app/templates/access_tokens/access_token.html"
], (Marionette, Template) ->
  class AccessTokenView extends Marionette.ItemView
    tagName: "a"

    className: "list-group-item"

    template: _.template(Template)

    attributes: =>
      href: "#access_tokens/#{@model.id}"