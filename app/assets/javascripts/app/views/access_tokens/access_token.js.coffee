define [
  "marionette",
  "text!app/templates/access_tokens/access_token.html"
], (Marionette, Template) ->
  class AccessTokenView extends Marionette.ItemView
    tagName: "li"

    className: "list-group-item"

    template: _.template(Template)
