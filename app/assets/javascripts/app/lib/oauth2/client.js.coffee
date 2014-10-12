define [
  "jquery",
  "app/lib/oauth2/strategies",
  "app/lib/oauth2/token"
], ($, Strategies, Token) ->
  class Client
    constructor: (options) ->
      @id = options.id
      @secret = options.secret
      @endpoint = options.endpoint
      @token_path = options.token_path || "/oauth/token"
      @proxy = options.proxy
      @strategies =
        client_credentials: options.client_credentials || Strategies.client_credentials
        password: options.password || Strategies.password

    get_token: (options = {}) ->
      response = null
      request_settings = $.extend({
        success: (_data, _status, xhr) -> response = xhr
        error: (_xhr, _status, error) -> throw new Error(error)
        async: false
      }, @_request_settings("post", @token_path, options))

      $.ajax(request_settings)
      response

    request: (method, path, options = {}) ->
      $.ajax(@_request_settings(method, path, options))

    client_credentials: ->
      @_client_credentials ||= new @strategies.client_credentials(client: @)

    password: ->
      @_password ||= new @strategies.password(client: @)

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
