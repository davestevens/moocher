define [
  "app/models/connections/no_auth",
  "text!app/templates/connections/show/no_auth.html",
  "text!app/templates/connections/form/no_auth.html",
  "app/models/connections/basic",
  "text!app/templates/connections/show/basic.html",
  "text!app/templates/connections/form/basic.html",
  "app/models/connections/oauth2",
  "text!app/templates/connections/show/oauth2.html",
  "text!app/templates/connections/form/oauth2.html"
], (NoAuthModel, NoAuthShow, NoAuthForm, BasicModel, BasicShow, BasicForm,
  OAuth2Model, OAuth2Show, OAuth2Form) ->
  model: (type) -> @get(type).model

  show_template: (type) -> @template(type).show

  form_template: (type) -> @template(type).form

  template: (type) -> @get(type).templates

  get: (type) -> @_connections[type]

  # private

  _connections:
    no_auth:
      model: NoAuthModel
      templates:
        show: NoAuthShow
        form: NoAuthForm
    basic:
      model: BasicModel
      templates:
        show: BasicShow
        form: BasicForm
    oauth2:
      model: OAuth2Model
      templates:
        show: OAuth2Show
        form: OAuth2Form
