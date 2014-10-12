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
      context "with a strategy not in the allowed list", ->
        it "is invalid", ->
          access_token = new AccessToken(strategy: "invalid strategy")

          result = access_token.isValid()

          expect(result).to.be.false
          expect(access_token.validationError).to.contain.key("strategy")

      context "with a strategy in the allowed list", ->
        it "is valid", ->
          access_token = new AccessToken(client_id: "foo", client_secret: "bar")
          access_token.set(strategy: _.keys(access_token.strategies)[0])

          result = access_token.isValid()

          expect(result).to.be.true

      context "with a blank client_id", ->
        it "is invalid", ->
          access_token = new AccessToken(client_id: "")

          result = access_token.isValid()

          expect(result).to.be.false
          expect(access_token.validationError).to.contain.key("client_id")

      context "with a blank client_secret", ->
        it "is invalid", ->
          access_token = new AccessToken(client_secret: "")

          result = access_token.isValid()

          expect(result).to.be.false
          expect(access_token.validationError).to.contain.key("client_secret")
