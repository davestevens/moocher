define ["app/lib/oauth2/tokens/client_credentials"], (ClientCredentialsToken) ->
  describe "Lib / OAuth2 / Tokens / ClientCredentials", ->
    describe "#refresh_parameters", ->
      it "return the required parameters for re-requesting an Access Token", ->
        client_id = "client_id"
        client_secret = "client_secret"
        client = new Object(id: client_id, secret: client_secret)
        token = new ClientCredentialsToken(client)

        result = token.refresh_parameters()

        expect(result).to.deep.equal({
          client_id: client_id
          client_secret: client_secret
          grant_type: "client_credentials"
        })
