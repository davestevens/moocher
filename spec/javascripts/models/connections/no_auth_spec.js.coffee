define ["app/models/connections/no_auth", "backbone"], (NoAuth, Backbone) ->
  describe "Models / Connections / NoAuth", ->
    create_no_auth = (attributes = {}, options = {}) ->
      new NoAuth(attributes, options)

    it "is a Backbone model", ->
      no_auth = create_no_auth()

      expect(no_auth).to.be.an.instanceOf(Backbone.Model)

    it "has default attributes", ->
      no_auth = create_no_auth()

      expect(no_auth.get("name")).to.equal("")
      expect(no_auth.get("endpoint")).to.be.null
      expect(no_auth.get("type")).to.equal("no_auth")

    describe "validations", ->
      valid_attributes =
        endpoint: "endpoint"

      context "with a blank endpoint", ->
        it "is invalid", ->
          no_auth = create_no_auth(valid_attributes)
          no_auth.set(endpoint: null)

          result = no_auth.isValid()

          expect(result).to.be.false
          expect(no_auth.validationError).to.contain.key("endpoint")

    describe "#request", ->
      it "makes a request through a Proxy", sinon.test ->
        proxy = { request: -> }
        request_stub = @stub(proxy, "request")
        endpoint = "http://example.com"
        no_auth = create_no_auth({ endpoint: endpoint }, { proxy: proxy })
        method = "GET"
        path = "/path"
        options = { foo: "bar" }

        no_auth.request(method, path, options)

        expect(request_stub)
          .to.have.been.calledWith(method, "#{endpoint}#{path}", options)
