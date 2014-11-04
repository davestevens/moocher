define [
  "app/services/form_item_view",
  "text!app/templates/connections/form.html"
], (FormItemView, Template) ->
  class ConnectionsEditView extends FormItemView
    form_template: Template
    action: "edit"
    button: "Update"
    route: "connections"
