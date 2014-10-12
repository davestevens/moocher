define [
  "marionette",
  "app/lib/oauth2/client",
  "text!app/templates/access_tokens/show.html"
], (Marionette, Client, Template) ->
  class AccessTokenView extends Marionette.ItemView
    modelEvents: { "change": -> @render() }

    template: (serialized_model) =>
      access_token = @_access_token()
      extra_options =
        expires_at: new Date(access_token.expires_at)
        expired: access_token.has_expired()
      attributes = _.extend(serialized_model, extra_options)
      _.template(Template, attributes)

    events:
      "click #validate_credentials": "_validate_credentials"
      "click #refresh": "_refresh"

    _validate_credentials: ->
      try
        access_token = @_strategy().get_token()
        @model.save(_.pick(access_token, _.keys(@model.attributes)))
      catch err
        alert(err)

    _refresh: ->
      access_token = @_access_token()
      access_token.refresh()
      @model.save(_.pick(access_token, _.keys(@model.attributes)))

    _access_token: ->
      @_strategy().token_from_hash(@model.attributes)

    _strategy: ->
      @_client()[@model.get("strategy")]()

    _client: ->
      @client ||= new Client
        id: @model.get("client_id")
        secret: @model.get("client_secret")
        endpoint: @model.get("endpoint")
        proxy:
          path: "/proxy"
          type: "post"
