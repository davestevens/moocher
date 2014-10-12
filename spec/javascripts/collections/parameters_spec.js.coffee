define [
  "app/collections/parameters",
  "backbone"
], (Parameters, Backbone) ->
  describe "Collections / Parameters", ->
    it "is a Backbone Collection", ->
      parameters = new Parameters()

      expect(parameters).to.be.an.instanceOf(Backbone.Collection)

    describe ".model", ->
      it "is a Parameter Model", ->
        parameters = new Parameters()

        result = parameters.model

        expect(result.name).to.equal("Parameter")

    describe "#url", ->
      it "is '/parameters'", ->
        parameters = new Parameters()

        result = parameters.url()

        expect(result).to.equal("/parameters")

    describe ".local", ->
      it "is true (uses Backbone.dualStorage to store data)", ->
        parameters = new Parameters()

        result = parameters.local

        expect(result).to.be.true

    describe "#selection", ->
      it "filters the collection based on passed ids", ->
        parameters = new Parameters([{ id: 1 }, { id: 2 }, { id: 3 }])

        result = parameters.selection([1, 2])

        expect(result).to.have.length(2)
