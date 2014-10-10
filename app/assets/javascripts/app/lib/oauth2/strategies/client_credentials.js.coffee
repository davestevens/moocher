define [
  "app/lib/oauth2/strategy",
  "app/lib/oauth2/tokens/client_credentials"
], (Strategy, ClientCredentialsToken) ->
  class ClientCredentialsStrategy extends Strategy
    parameters: ->
      grant_type: "client_credentials"
      client_id: @client.id
      client_secret: @client.secret

    token_class: ClientCredentialsToken
