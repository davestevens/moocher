define [
  "app/models/request",
  "backbone"
], (Request, Backbone) ->
  describe "Models / Request", ->
    it "it a Backbone model", ->
      request = new Request()

      expect(request).to.be.an.instanceOf(Backbone.Model)

    it "has default attributes", ->
      request = new Request()

      expect(request.get("name")).to.equal("")
      expect(request.get("connection_id")).to.be.null

      expect(request.get("path")).to.equal("/")
      expect(request.get("method")).to.equal("GET")

      expect(request.get("headers")).to.be.an.instanceOf(Backbone.Collection)
      expect(request.get("parameters")).to.be.an.instanceOf(Backbone.Collection)
      expect(request.get("encoding")).to.deep.equal("form")

    describe "#parse", ->
      xit "creates collections for headers and parameters", ->

    describe "#toJSON", ->
      xit "converts headers and parameters to arry of ids", ->

    describe "#options", ->
      context "when using Form encoding", ->
        it "returns headers and form encoded parameters", ->
          params = new Backbone.Collection([
            new Backbone.Model(name: "foo", value: "bar", active: true)
          ])
          request = new Request
            encoding: "form"
            headers: params
            parameters: params

          result = request.options()

          expect(result)
            .to.deep.equal(headers: { foo: "bar" }, parameters: "foo=bar")

      context "when using JSON encoding", ->
        it "returns headers and parameters hash", ->
          params = new Backbone.Collection([
            new Backbone.Model(name: "foo", value: "bar", active: true)
          ])
          request = new Request
            encoding: "json"
            headers: params
            parameters: params

          result = request.options()

          expect(result)
            .to.deep.equal(headers: { foo: "bar" }, parameters: { foo: "bar" })
