define [
  "marionette",
  "app/views/connections/connection",
  "text!app/templates/connections/index.html"
], (Marionette, ConnectionView, Template) ->
  class ConnectionsView extends Marionette.CompositeView
    childView: ConnectionView

    childViewContainer: ".list-group"

    template: _.template(Template)
