define [
  "app/lib/oauth2/strategies/client_credentials",
  "app/lib/oauth2/strategy"
], (ClientCredentials, Strategy) ->
  describe "Lib / OAuth2 / Strategies / ClientCredentials", ->
    it "extends Strategy", ->
      client = new Object()
      client_credentials_strategy = new ClientCredentials(client: client)

      expect(client_credentials_strategy).to.be.an.instanceOf(Strategy)

    describe "#parameters", ->
      it "return the required parameters for requesting an Access Token", ->
        client_id = "client_id"
        client_secret = "client_secret"
        client = new Object(id: client_id, secret: client_secret)
        client_credentials_strategy = new ClientCredentials(client: client)

        result = client_credentials_strategy.parameters()

        expect(result).to.deep.equal({
          grant_type: "client_credentials"
          client_id: client_id
          client_secret: client_secret
        })
