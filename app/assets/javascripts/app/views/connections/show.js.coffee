define [
  "marionette",
  "app/lib/oauth2/client",
  "text!app/templates/connections/show/no_auth.html",
  "text!app/templates/connections/show/oauth2.html"
], (Marionette, Client, NoAuth, OAuth2) ->
  class ConnectionsShowView extends Marionette.ItemView
    events:
      "click #validate_credentials": "_validate_credentials"
      "click #refresh": "_refresh"

    modelEvents: { "change": -> @render() }

    getTemplate: -> _.template(@_get_template())

    templateHelpers:
      expires_at_date: -> new Date(@expires_at)

    # private

    _get_template: -> @_templates[@model.get("type")]

    _templates:
      no_auth: NoAuth
      oauth2: OAuth2

    _validate_credentials: ->
      try @model.validate_access_token()
      catch err then alert(err)

    _refresh: -> @model.refresh()
