define ["app/lib/oauth2/strategy"], (Strategy) ->
  class ClientCredentialsStrategy extends Strategy
    parameters: ->
      grant_type: "client_credentials"
      client_id: @client.id
      client_secret: @client.secret
