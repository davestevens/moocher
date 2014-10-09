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
      @proxy = options.proxy
      @strategies =
        client_credentials: options.client_credentials || Strategy
        password: options.password || Strategy

    get_token: (options = {}) ->
      response = null
      request_settings = $.extend({
        success: (_data, _status, xhr) -> response = xhr
        error: (xhr, _status, _error) -> response = xhr
        async: false
      }, @_request_settings("post", @token_path, options))

      $.ajax(request_settings)
      response

    request: (method, path, options = {}) ->
      $.ajax(@_request_settings(method, path, options))

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

    _request_settings: (method, post, options = {}) ->
      if @proxy
        @_proxy_request_options(method, post, options)
      else
        @_request_options(method, post, options)

    _request_options: (method, path, options = {}) ->
      type: method
      url: @_build_url(path)
      headers: options.headers
      data: options.parameters

    _proxy_request_options: (method, path, options = {}) ->
      type: @proxy.type || "post"
      url: @proxy.path
      data: @_request_options(method, path, options)
