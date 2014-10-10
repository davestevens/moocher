define ["app/lib/oauth2/strategy"], (Strategy) ->
  class PasswordStrategy extends Strategy
    parameters: (username, password) ->
      grant_type: "password"
      client_id: @client.id
      client_secret: @client.secret
      username: username
      password: password
