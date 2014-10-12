define [
  "app/lib/oauth2/strategy",
  "app/lib/oauth2/tokens/password"
], (Strategy, PasswordToken) ->
  class PasswordStrategy extends Strategy
    token_class: PasswordToken

    parameters: (options = {}) ->
      grant_type: "password"
      client_id: @client.id
      client_secret: @client.secret
      username: options.username
      password: options.password
