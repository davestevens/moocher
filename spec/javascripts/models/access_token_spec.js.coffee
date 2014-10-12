define [
  "app/models/access_token",
  "backbone"
], (AccessToken, Backbone) ->
  describe "Models / AccessToken", ->
    it "it a Backbone model", ->
      access_token = new AccessToken()

      expect(access_token).to.be.an.instanceOf(Backbone.Model)

    it "has default attributes", ->
      access_token = new AccessToken()

      expect(access_token.get("name")).to.equal("")
      expect(access_token.get("strategy")).to.be.null

      expect(access_token.get("client_id")).to.be.null
      expect(access_token.get("client_secret")).to.be.null

      expect(access_token.get("access_token")).to.be.null
      expect(access_token.get("expires_at")).to.be.null
      expect(access_token.get("refresh_token")).to.be.null
      expect(access_token.get("token_type")).to.equal("bearer")

    describe "Validations", ->
      valid_attributes =
        strategy: "client_credentials"
        client_id: "client_id"
        client_secret: "client_secret"
        endpoint: "endpoint"

      context "with a strategy not in the allowed list", ->
        it "is invalid", ->
          access_token = new AccessToken(valid_attributes)
          access_token.set(strategy: "invalid strategy")

          result = access_token.isValid()

          expect(result).to.be.false
          expect(access_token.validationError).to.contain.key("strategy")

      context "with a strategy in the allowed list", ->
        it "is valid", ->
          access_token = new AccessToken(valid_attributes)
          access_token.set(strategy: _.keys(access_token.strategies)[0])

          result = access_token.isValid()

          expect(result).to.be.true

      context "with a blank client_id", ->
        it "is invalid", ->
          access_token = new AccessToken(valid_attributes)
          access_token.set(client_id: "")

          result = access_token.isValid()

          expect(result).to.be.false
          expect(access_token.validationError).to.contain.key("client_id")

      context "with a blank client_secret", ->
        it "is invalid", ->
          access_token = new AccessToken(valid_attributes)
          access_token.set(client_secret: "")

          result = access_token.isValid()

          expect(result).to.be.false
          expect(access_token.validationError).to.contain.key("client_secret")

      context "with a blank endpoint", ->
        it "is invalid", ->
          access_token = new AccessToken(valid_attributes)
          access_token.set(endpoint: "")

          result = access_token.isValid()

          expect(result).to.be.false
          expect(access_token.validationError).to.contain.key("endpoint")

    describe ".strategies", ->
      it "is a hash of available OAuth2 Strategies", ->
        access_token = new AccessToken()

        result = access_token.strategies

        expect(result).to.have.keys("client_credentials", "password")

    describe "#access_token", ->
      it "builds an OAuth2 AccessToken from the current Model", sinon.test ->
        access_token = new AccessToken()
        strategy = new Object(token_from_hash: $.noop)
        @spy(strategy, "token_from_hash")
        @stub(access_token, "_strategy", -> strategy)

        access_token.access_token()

        expect(strategy.token_from_hash).to.have.been.called

    describe "#refresh", ->
      it "refreshes the OAuth2 AccessToken", sinon.test ->
        access_token = new AccessToken()
        token = new Object(refresh: $.noop)
        @spy(token, "refresh")
        @stub(access_token, "access_token", -> token)

        access_token.refresh()

        expect(token.refresh).to.have.been.called

      it "saves the new AccessToken attributes", sinon.test ->
        access_token = new AccessToken()
        token = new Object(
          refresh: $.noop
          access_token: "access_token"
          refresh_token: "refresh_token"
        )
        @stub(access_token, "access_token", -> token)
        @spy(access_token, "save")

        access_token.refresh()

        expect(access_token.save).to.have.been.calledWith
          access_token: "access_token"
          refresh_token: "refresh_token"

    describe "#validate_access_token", ->
      it "builds a new OAuth2 AccessToken from the current Model", sinon.test ->
        access_token = new AccessToken()
        strategy = new Object(get_token: -> new Object())
        @spy(strategy, "get_token")
        @stub(access_token, "_strategy", -> strategy)

        access_token.validate_access_token()

        expect(strategy.get_token).to.have.been.called

      it "saves the new AccessToken attributes", sinon.test ->
        access_token = new AccessToken()
        strategy = new Object(get_token: $.noop)
        token = new Object(
          access_token: "access_token"
          refresh_token: "refresh_token"
        )
        @stub(strategy, "get_token", -> token)
        @stub(access_token, "_strategy", -> strategy)
        @spy(access_token, "save")

        access_token.validate_access_token()

        expect(access_token.save).to.have.been.calledWith
          access_token: "access_token"
          refresh_token: "refresh_token"
