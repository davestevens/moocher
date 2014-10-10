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

    request: (method, path, options = {}) ->
      @refresh() if @has_expired()
      options.headers = $.merge(@_headers(), options.headers?)
      @client.request(method, path, options)

    get: (path, options) -> @request("GET", path, options)

    refresh: ->
      data = @client.get_token(parameters: @_refresh_parameters())
      @set_data(data.responseJSON)

    has_expired: -> +Date.now() >= @expires_at

    # private
    _expires_at: (expires_in) -> +Date.now() + (expires_in * 1000)

    _headers: -> Authorization: "Bearer #{@access_token}"

    _refresh_parameters: ->
      throw new Error("Cannot refresh token") unless @refresh_token
      {
        client_id: @client.id
        client_secret: @client.secret
        grant_type: "refresh_token"
        refresh_token: @refresh_token
      }