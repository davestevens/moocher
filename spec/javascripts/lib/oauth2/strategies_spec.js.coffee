define [
  "app/lib/oauth2/strategies",
  "app/lib/oauth2/strategy",
  "app/lib/oauth2/strategies/client_credentials",
  "app/lib/oauth2/strategies/password",
], (Strategies, Strategy, ClientCredentialsStrategy, PasswordStrategy) ->
  describe "Lib / OAuth2 / Strategies", ->
    describe ".base", ->
      it "is the Strategy Class", ->
        expect(Strategies.base).to.equal(Strategy)

    describe ".client_credentials", ->
      it "is the ClientCredentials Strategy Class", ->
        expect(Strategies.client_credentials)
          .to.equal(ClientCredentialsStrategy)

    describe ".password", ->
      it "is the Password Strategy Class", ->
        expect(Strategies.password).to.equal(PasswordStrategy)
