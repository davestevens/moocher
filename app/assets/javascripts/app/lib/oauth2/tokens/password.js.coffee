define ["app/lib/oauth2/token"], (Token) ->
  class PasswordToken extends Token
    refresh_parameters: ->
      throw new Error("Cannot refresh PasswordToken") unless @refresh_token
      {
        client_id: @client.id
        client_secret: @client.secret
        grant_type: "refresh_token"
        refresh_token: @refresh_token
      }
