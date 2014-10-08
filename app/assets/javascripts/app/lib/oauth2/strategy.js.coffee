define [
  "jquery",
  "app/lib/oauth2/token"
], ($, Token) ->
  class Strategy
    constructor: (options) ->
      @client = options.client
      @token_class = options.token_class || Token
      @parameters = options.parameters || $.noop

    token_from_hash: (data) -> new @token_class(@client, data)

    get_token: ->
      parameters = @parameters(arguments...)
      data = @client.get_token(parameters: parameters)
      @token_from_hash(data.responseJSON)
