define [
  "app/lib/oauth2/strategies/password",
  "app/lib/oauth2/strategy"
], (Password, Strategy) ->
  describe "Lib / OAuth2 / Strategies / Password", ->
    it "extends Strategy", ->
      client = new Object()
      password_strategy = new Password(client: client)

      expect(password_strategy).to.be.an.instanceOf(Strategy)

    describe ".token_class", ->
      it "is 'PasswordToken'", ->
        token_class = new Password({}).token_class

        result = token_class.name

        expect(result).to.equal("PasswordToken")

    describe "#parameters", ->
      it "return the required parameters for requesting an Access Token", ->
        client_id = "client_id"
        client_secret = "client_secret"
        client = new Object(id: client_id, secret: client_secret)
        password_strategy = new Password(client: client)
        username = "username"
        password = "password"

        result = password_strategy
          .parameters(username: username, password: password)

        expect(result).to.deep.equal({
          grant_type: "password"
          client_id: client_id
          client_secret: client_secret
          username: username
          password: password
        })
