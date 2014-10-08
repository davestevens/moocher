define [
  "jquery",
  "app/lib/oauth2/strategy",
  "app/lib/oauth2/token"
], ($, Strategy, Token) ->
  class Client
    constructor: (options) ->
      @id = options.id
      @secret = options.secret
      @endpoint = options.endpoint
      @token_path = options.token_path || "/oauth/token"
      @strategies =
        client_credentials: options.client_credentials || Strategy
        password: options.password || Strategy

    get_token: (options = {}) ->
      response = null
      $.ajax
        type: "post"
        url: "/proxy"
        data:
          proxy:
            method: "post"
            endpoint: @endpoint
            path: @token_path
            headers: options.headers
            parameters: options.parameters
        success: (_data, _status, xhr) -> response = xhr
        error: (xhr, _status, _error) -> response = xhr
        async: false
      response

    request: (method, path, options = {}) ->
      $.ajax
        type: "post"
        url: "/proxy"
        data:
          proxy:
            method: method
            endpoint: @endpoint
            path: path
            headers: options.headers
            parameters: options.parameters

    client_credentials: ->
      @_client_credentials ||= new @strategies.client_credentials
        client: @
        parameters: ->
          grant_type: "client_credentials"
          client_id: @client.id
          client_secret: @client.secret

    password: ->
      @_password ||= new @strategies.password
        client: @
        parameters: (username, password)->
          grant_type: "password"
          client_id: @client.id
          client_secret: @client.secret
          username: username
          password: password

    # private
    _build_url: (path) -> "#{@endpoint}#{path}"
