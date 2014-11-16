define [
  "app/collections/connections",
  "backbone",
  "app/models/connections/no_auth",
  "app/models/connections/oauth2"
], (Connections, Backbone, NoAuth, OAuth2) ->
  describe "Collections / Connections", ->
    it "is a Backbone Collection", ->
      connections = new Connections()

      expect(connections).to.be.an.instanceOf(Backbone.Collection)

    describe "#parse", ->
      context "whem model type is 'no_auth'", ->
        it "instantiates a 'NoAuth' model", ->
          connections = new Connections()

          result = connections.parse([ { type: "no_auth" }])[0]

          expect(result).to.be.an.instanceOf(NoAuth)

      context "whem model type is 'oauth2'", ->
        it "instantiates a 'OAuth2' model", ->
          connections = new Connections()

          result = connections.parse([ { type: "oauth2" }])[0]

          expect(result).to.be.an.instanceOf(OAuth2)

    describe "#url", ->
      it "is '/connections'", ->
        connections = new Connections()

        result = connections.url()

        expect(result).to.equal("/connections")

    describe ".local", ->
      it "is true (uses Backbone.dualStorage to store data)", ->
        connections = new Connections()

        result = connections.local

        expect(result).to.be.true
