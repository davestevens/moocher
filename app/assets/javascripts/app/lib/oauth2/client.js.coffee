define [
  "jquery",
  "app/lib/oauth2/services/connection_object",
  "app/lib/oauth2/strategies",
  "app/lib/oauth2/token"
], ($, ConnectionObject, Strategies, Token) ->
  class Client
    constructor: (options) ->
      @id = options.id
      @secret = options.secret
      @endpoint = options.endpoint
      @token_path = options.token_path || "/oauth/token"
      @connection = options.connection || new ConnectionObject()
      @strategies =
        client_credentials: options.client_credentials || Strategies.client_credentials
        password: options.password || Strategies.password

    get_token: (options = {}) ->
      response = null
      _.extend(options, {
        success: (_data, _status, xhr) -> response = xhr
        error: (_xhr, _status, error) -> throw new Error(error)
        async: false
      })
      url = @_build_url(@token_path)

      @connection.request("post", url, options)
      response

    request: (method, path, options = {}) ->
      url = @_build_url(path)
      @connection.request(method, url, options)

    client_credentials: ->
      @_client_credentials ||= new @strategies.client_credentials(client: @)

    password: ->
      @_password ||= new @strategies.password(client: @)

    # private
    _build_url: (path) -> "#{@endpoint}#{path}"
