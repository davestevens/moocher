define [
  "marionette",
  "text!app/templates/access_tokens/show.html"
], (Marionette, Template) ->
  class AccessTokenView extends Marionette.ItemView
    template: _.template(Template)
