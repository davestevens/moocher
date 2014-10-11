define [
  "app/collections/access_tokens",
  "backbone"
], (AccessTokens, Backbone) ->
  describe "Collections / AccessTokens", ->
    it "is a Backbone Collection", ->
      access_tokens = new AccessTokens()

      expect(access_tokens).to.be.an.instanceOf(Backbone.Collection)

    describe ".model", ->
      it "is a AccessToken Model", ->
        access_tokens = new AccessTokens()

        result = access_tokens.model

        expect(result.name).to.equal("AccessToken")

    describe "#url", ->
      it "is '/access_tokens'", ->
        access_tokens = new AccessTokens()

        result = access_tokens.url()

        expect(result).to.equal("/access_tokens")

    describe ".local", ->
      it "is true (uses Backbone.dualStorage to store data)", ->
        access_tokens = new AccessTokens()

        result = access_tokens.local

        expect(result).to.be.true
