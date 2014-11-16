define ["app/lib/oauth2/tokens/password"], (PasswordToken) ->
  describe "Lib / OAuth2 / Tokens / Password", ->
    describe "#refresh_parameters", ->
      context "when @refresh_token is not defined", ->
        it "throws Error", ->
          token = new PasswordToken()

          expect(-> token.refresh_parameters())
          .to.throw(Error, "Cannot refresh PasswordToken")

      context "when @refresh_token not defined", ->
        it "return the required parameters for refreshing an Access Token", ->
          client_id = "client_id"
          client_secret = "client_secret"
          client = new Object(id: client_id, secret: client_secret)
          refresh_token = "refresh_token"
          token = new PasswordToken(client, { refresh_token: refresh_token })

          result = token.refresh_parameters()

          expect(result).to.deep.equal({
            client_id: client_id
            client_secret: client_secret
            grant_type: "refresh_token"
            refresh_token: refresh_token
          })
