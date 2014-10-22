define [
  "app/services/form_item_view",
  "text!app/templates/connections/form.html"
], (FormItemView, Template) ->
  class ConnectionsNewView extends FormItemView
    form_template: Template
    action: "new"
    button: "Create"
    route: "connections"
