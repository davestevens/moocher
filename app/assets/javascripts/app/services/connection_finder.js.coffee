define [
  "app/models/connections/no_auth",
  "text!app/templates/connections/show/no_auth.html",
  "app/models/connections/oauth2",
  "text!app/templates/connections/show/oauth2.html"
], (NoAuthModel, NoAuthTemplate, OAuth2Model, OAuth2Template) ->
  model: (type) -> @get(type).model

  template: (type) -> @get(type).template

  get: (type) -> @_connections[type]

  # private

  _connections:
    no_auth:
      model: NoAuthModel
      template: NoAuthTemplate
    oauth2:
      model: OAuth2Model
      template: OAuth2Template
