define [
  "app/collections/connections",
  "backbone"
], (Connections, Backbone) ->
  describe "Collections / Connections", ->
    it "is a Backbone Collection", ->
      connections = new Connections()

      expect(connections).to.be.an.instanceOf(Backbone.Collection)

    describe ".model", ->
      it "is a Connection Model", ->
        connections = new Connections()

        result = connections.model

        expect(result.name).to.equal("Connection")

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
