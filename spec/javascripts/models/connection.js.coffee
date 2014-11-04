define [
  "app/models/connection",
  "backbone"
], (Connection], Backbone) ->
  describe "Models / Connection]", ->
    it "it a Backbone model", ->
      connection = new Connection]()

      expect(connection).to.be.an.instanceOf(Backbone.Model)

    it "has default attributes", ->
      connection = new Connection]()

      expect(connection.get("name")).to.equal("")
      expect(connection.get("strategy")).to.be.null

      expect(connection.get("client_id")).to.be.null
      expect(connection.get("client_secret")).to.be.null

      expect(connection.get("connection")).to.be.null
      expect(connection.get("expires_at")).to.be.null
      expect(connection.get("refresh_token")).to.be.null
      expect(connection.get("token_type")).to.equal("bearer")

    describe "Validations", ->
      valid_attributes =
        strategy: "client_credentials"
        client_id: "client_id"
        client_secret: "client_secret"
        endpoint: "endpoint"

      context "with a strategy not in the allowed list", ->
        it "is invalid", ->
          connection = new Connection](valid_attributes)
          connection.set(strategy: "invalid strategy")

          result = connection.isValid()

          expect(result).to.be.false
          expect(connection.validationError).to.contain.key("strategy")

      context "with a strategy in the allowed list", ->
        it "is valid", ->
          connection = new Connection](valid_attributes)
          connection.set(strategy: _.keys(connection.strategies)[0])

          result = connection.isValid()

          expect(result).to.be.true

      context "with a blank client_id", ->
        it "is invalid", ->
          connection = new Connection](valid_attributes)
          connection.set(client_id: "")

          result = connection.isValid()

          expect(result).to.be.false
          expect(connection.validationError).to.contain.key("client_id")

      context "with a blank client_secret", ->
        it "is invalid", ->
          connection = new Connection](valid_attributes)
          connection.set(client_secret: "")

          result = connection.isValid()

          expect(result).to.be.false
          expect(connection.validationError).to.contain.key("client_secret")

      context "with a blank endpoint", ->
        it "is invalid", ->
          connection = new Connection](valid_attributes)
          connection.set(endpoint: "")

          result = connection.isValid()

          expect(result).to.be.false
          expect(connection.validationError).to.contain.key("endpoint")

    describe ".strategies", ->
      it "is a hash of available OAuth2 Strategies", ->
        connection = new Connection]()

        result = connection.strategies

        expect(result).to.have.keys("client_credentials", "password")

    describe "#connection", ->
      it "builds an OAuth2 Connection] from the current Model", sinon.test ->
        connection = new Connection]()
        strategy = new Object(token_from_hash: $.noop)
        @spy(strategy, "token_from_hash")
        @stub(connection, "_strategy", -> strategy)

        connection.connection()

        expect(strategy.token_from_hash).to.have.been.called

    describe "#refresh", ->
      it "refreshes the OAuth2 Connection]", sinon.test ->
        connection = new Connection]()
        token = new Object(refresh: $.noop)
        @spy(token, "refresh")
        @stub(connection, "connection", -> token)

        connection.refresh()

        expect(token.refresh).to.have.been.called

      it "saves the new Connection] attributes", sinon.test ->
        connection = new Connection]()
        token = new Object(
          refresh: $.noop
          connection: "connection"
          refresh_token: "refresh_token"
        )
        @stub(connection, "connection", -> token)
        @spy(connection, "save")

        connection.refresh()

        expect(connection.save).to.have.been.calledWith
          connection: "connection"
          refresh_token: "refresh_token"

    describe "#validate_connection", ->
      it "builds a new OAuth2 Connection] from the current Model", sinon.test ->
        connection = new Connection]()
        strategy = new Object(get_token: -> new Object())
        @spy(strategy, "get_token")
        @stub(connection, "_strategy", -> strategy)

        connection.validate_connection()

        expect(strategy.get_token).to.have.been.called

      it "saves the new Connection] attributes", sinon.test ->
        connection = new Connection()
        strategy = new Object(get_token: $.noop)
        token = new Object(
          connection: "connection"
          refresh_token: "refresh_token"
        )
        @stub(strategy, "get_token", -> token)
        @stub(connection, "_strategy", -> strategy)
        @spy(connection, "save")

        connection.validate_connection()

        expect(connection.save).to.have.been.calledWith
          connection: "connection"
          refresh_token: "refresh_token"
