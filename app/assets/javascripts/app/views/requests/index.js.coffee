define [
  "marionette",
  "app/views/requests/request",
  "text!app/templates/requests/index.html"
], (Marionette, RequestView, Template) ->
  class RequestsView extends Marionette.CompositeView
    childView: RequestView

    childViewContainer: ".list-group"

    template: _.template(Template)
