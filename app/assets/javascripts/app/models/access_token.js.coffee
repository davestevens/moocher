define [
  "backbone",
  "underscore",
  "jquery",
  "app/services/model_errors",
  "app/lib/oauth2/client"
], (Backbone, _, $, ModelErrors, OAuth2Client) ->
  class AccessToken extends Backbone.Model
    defaults:
      name: ""
      strategy: null
      client_id: null
      client_secret: null
      endpoint: null
      username: null
      password: null
      access_token: null
      expires_at: null
      refresh_token: null
      token_type: "bearer"

    validate: (attrs, options) ->
      errors = new ModelErrors(attrs)
      errors.validate_blank("client_id", "client_secret", "endpoint")
      errors.validate_inclusion("strategy", _.keys(@strategies))
      errors.result()

    strategies:
      client_credentials: "Client Credentials"
      password: "Password"

    access_token: -> @_acces_token ||= @_strategy().token_from_hash(@attributes)

    request: (method, path, options = {}) ->
      $(@access_token()).on("update", @_update_model)
      @access_token().request(method, path, options)

    refresh: ->
      @access_token().refresh()
      @save(_.pick(@access_token(), _.keys(@attributes)))

    validate_access_token: ->
      access_token = @_strategy().get_token(@pick("username", "password"))
      @save(_.pick(access_token, _.keys(@attributes)))

    # private
    _update_model: (_event, token) => @save(_.pick(token, _.keys(@attributes)))

    _strategy: -> @_client()[@get("strategy")]()

    _client: -> new OAuth2Client(@_client_options())

    _client_options: ->
      id: @get("client_id")
      secret: @get("client_secret")
      endpoint: @get("endpoint")
      proxy:
        path: "/proxy"
        type: "post"
