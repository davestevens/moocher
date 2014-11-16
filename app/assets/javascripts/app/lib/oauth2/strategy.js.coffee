define ["jquery", "app/lib/oauth2/token"], ($, Token) ->
  class Strategy
    constructor: (options) ->
      @client = options.client
      @token = options.token || new @token_class(@client)

    token_class: Token

    token_from_hash: (data) -> @token.set_data(data)

    get_token: ->
      parameters = @parameters(arguments...)
      data = @client.get_token(parameters: parameters)
      @token_from_hash(data.responseJSON)

    parameters: $.noop
