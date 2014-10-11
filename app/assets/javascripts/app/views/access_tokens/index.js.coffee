define [
  "marionette",
  "app/views/access_tokens/access_token",
  "text!app/templates/access_tokens/index.html"
], (Marionette, AccessTokenView, Template) ->
  class AccessTokensView extends Marionette.CompositeView
    childView: AccessTokenView

    childViewContainer: "ul"

    template: _.template(Template)
