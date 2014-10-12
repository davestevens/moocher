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
      expect(request.get("access_token_id")).to.be.null

      expect(request.get("path")).to.equal("/")
      expect(request.get("method")).to.equal("GET")

      expect(request.get("header_ids")).to.deep.equal([])
      expect(request.get("parameter_ids")).to.deep.equal([])

    describe "#push", ->
      it "adds a value to an array attribute", sinon.test ->
        request = new Request(header_ids: [1, 2, 3])
        request.url = "/fake/path"

        request.push("header_ids", 4)

        expect(request.get("header_ids")).to.deep.equal([1, 2, 3, 4])

    describe "#splice", ->
      it "remove a value to an array attribute", sinon.test ->
        request = new Request(header_ids: [1, 2, 3])
        request.url = "/fake/path"

        request.splice("header_ids", 2)

        expect(request.get("header_ids")).to.deep.equal([1, 3])

    describe "#options", ->
      it "returns headers and parameters hash", sinon.test ->
        request = new Request()
        parameters = [new Backbone.Model(name: "foo", value: "bar",
        active: true)]
        parameters_collection = new Object(selection: -> parameters)
        @stub(request, "_parameters_collection", -> parameters_collection)

        result = request.options()

        expect(result)
          .to.deep.equal(headers: { foo: "bar" }, parameters: { foo: "bar" })
