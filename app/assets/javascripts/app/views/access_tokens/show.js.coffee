define [
  "marionette",
  "app/lib/oauth2/client",
  "text!app/templates/access_tokens/show.html"
], (Marionette, Client, Template) ->
  class AccessTokenView extends Marionette.ItemView
    events:
      "click #validate_credentials": "_validate_credentials"
      "click #refresh": "_refresh"

    modelEvents: { "change": -> @render() }

    template: (serialized_model) =>
      attributes = _.extend(serialized_model, @_view_attributes())
      _.template(Template, attributes)

    _view_attributes: ->
      access_token = @model.access_token()
      {
        expires_at: new Date(access_token.expires_at)
        expired: access_token.has_expired()
      }

    _validate_credentials: ->
      try @model.validate_access_token()
      catch err then alert(err)

    _refresh: -> @model.refresh()
