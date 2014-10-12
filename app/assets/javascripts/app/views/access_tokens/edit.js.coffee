define [
  "app/services/form_item_view",
  "text!app/templates/access_tokens/form.html"
], (FormItemView, Template) ->
  class AccessTokensEditView extends FormItemView
    form_template: Template
    action: "edit"
    button: "Update"
    route: "access_tokens"
