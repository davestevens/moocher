define [
  "app/services/form_item_view",
  "text!app/templates/access_tokens/form.html"
], (FormItemView, Template) ->
  class AccessTokensNewView extends FormItemView
    form_template: Template
    action: "new"
    button: "Create"
    route: "access_tokens"
