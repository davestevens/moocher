define [
  "app/collections/requests",
  "backbone"
], (Requests, Backbone) ->
  describe "Collections / Requests", ->
    it "is a Backbone Collection", ->
      requests = new Requests()

      expect(requests).to.be.an.instanceOf(Backbone.Collection)

    describe ".model", ->
      it "is a Parameter Model", ->
        requests = new Requests()

        result = requests.model

        expect(result.name).to.equal("Request")

    describe "#url", ->
      it "is '/requests'", ->
        requests = new Requests()

        result = requests.url()

        expect(result).to.equal("/requests")

    describe ".local", ->
      it "is true (uses Backbone.dualStorage to store data)", ->
        requests = new Requests()

        result = requests.local

        expect(result).to.be.true
