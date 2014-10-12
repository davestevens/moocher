define [
  "app/models/parameter",
  "backbone"
], (Parameter, Backbone) ->
  describe "Models / Parameter", ->
    it "is a Backbone Model", ->
      parameter = new Parameter()

      expect(parameter).to.be.an.instanceOf(Backbone.Model)

    it "has default attributes", ->
      parameter = new Parameter()

      expect(parameter.get("name")).to.equal("")
      expect(parameter.get("value")).to.equal("")
      expect(parameter.get("active")).to.be.false
