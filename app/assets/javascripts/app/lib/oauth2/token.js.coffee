define ->
  class Token
    constructor: (client, options = {}) ->
      @client = client
      @set_data(options)

    set_data: (options) ->
      @access_token = options.access_token
      @expires_at = options.expires_at || @_expires_at(options.expires_in)
      @refresh_token = options.refresh_token
      @token_type = options.token_type
      @

    request: (method, path, options = {}) ->
      @refresh() if @has_expired()
      options.headers = $.merge(@_headers(), options.headers?)
      @client.request(method, path, options)

    get: (path, options) -> @request("GET", path, options)

    post: (path, options) -> @request("POST", path, options)

    put: (path, options) -> @request("PUT", path, options)

    delete: (path, options) -> @request("DELETE", path, options)

    head: (path, options) -> @request("HEAD", path, options)

    refresh: ->
      data = @client.get_token(parameters: @refresh_parameters())
      @set_data(data.responseJSON)

    refresh_parameters: -> throw new Error("Cannot refresh Token")

    has_expired: -> +Date.now() >= @expires_at

    # private
    _expires_at: (expires_in) -> +Date.now() + (expires_in * 1000)

    _headers: -> Authorization: "Bearer #{@access_token}"
