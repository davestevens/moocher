define ->
  class Client
    constructor: (options) ->
      @id = options.id
      @secret = options.secret
      @endpoint = options.endpoint
      @token_path = options.token_path || "/oauth/token"
      @strategies =
        client_credentials: options.client_credentials
        password: options.password

    get_token: (options = {}) ->
      response = null
      $.ajax
        type: "post"
        url: @_build_url(@token_path)
        headers: options.headers
        data: options.parameters
        success: (_data, _status, xhr) -> response = xhr
        error: (xhr, _status, _error) -> response = xhr
        async: false
      response

    request: (method, path, options = {}) ->
      $.ajax
        type: method
        url: @_build_url(path)
        headers: options.headers
        data: options.parameters

    client_credentials: ->
      @_client_credentials ||= new @strategies.client_credentials(@)

    password: ->
      @_password ||= new @strategies.password(@)

    # private
    _build_url: (path) -> "#{@endpoint}#{path}"
