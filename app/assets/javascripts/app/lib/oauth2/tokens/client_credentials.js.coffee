define ["app/lib/oauth2/token"], (Token) ->
  class ClientCredentialsToken extends Token
    # NOTE: This performs a Request rather than a Refresh
    refresh_parameters: ->
      client_id: @client.id
      client_secret: @client.secret
      grant_type: "client_credentials"
