define [
  "marionette",
  "app/lib/oauth2/client",
  "app/services/connection_finder"
], (Marionette, Client, ConnectionFinder) ->
  class ConnectionsShowView extends Marionette.ItemView
    events:
      "click #validate_credentials": "_validate_credentials"
      "click #refresh": "_refresh"

    modelEvents: { "change": -> @render() }

    getTemplate: -> _.template(ConnectionFinder.template(@model.get("type")))

    templateHelpers:
      expires_at_date: -> new Date(@expires_at)
      expired: -> @expires_at_date() < new Date()

    # private

    _validate_credentials: ->
      try @model.validate_access_token()
      catch err then alert(err)

    _refresh: ->
      try @model.refresh()
      catch err then alert(err)
