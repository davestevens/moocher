define ["app/models/connections/basic", "backbone"], (Basic, Backbone) ->
  describe "Models / Connections / Basic", ->
    create_basic = (attributes = {}, options = {}) ->
      new Basic(attributes, options)

    it "is a Backbone model", ->
      basic = create_basic()

      expect(basic).to.be.an.instanceOf(Backbone.Model)

    it "has default attributes", ->
      basic = create_basic()

      expect(basic.get("name")).to.equal("")
      expect(basic.get("endpoint")).to.be.null
      expect(basic.get("username")).to.be.null
      expect(basic.get("password")).to.be.null
      expect(basic.get("type")).to.equal("basic")

    describe "validations", ->
      valid_attributes =
        endpoint: "endpoint"
        username: "username"
        password: "password"

      context "with a blank endpoint", ->
        it "is invalid", ->
          basic = create_basic(valid_attributes)
          basic.set(endpoint: null)

          result = basic.isValid()

          expect(result).to.be.false
          expect(basic.validationError).to.contain.key("endpoint")

      context "with a blank username", ->
        it "is invalid", ->
          basic = create_basic(valid_attributes)
          basic.set(username: null)

          result = basic.isValid()

          expect(result).to.be.false
          expect(basic.validationError).to.contain.key("username")

      context "with a blank password", ->
        it "is invalid", ->
          basic = create_basic(valid_attributes)
          basic.set(password: null)

          result = basic.isValid()

          expect(result).to.be.false
          expect(basic.validationError).to.contain.key("password")

    describe "#request", ->
      it "makes a request through a Proxy", sinon.test ->
        proxy = { request: -> }
        request_stub = @stub(proxy, "request")
        endpoint = "http://example.com"
        username = "username"
        password = "password"
        basic = create_basic(
          { endpoint: endpoint, username: username, password: password },
          { proxy: proxy }
        )
        method = "GET"
        path = "/path"
        options = { foo: "bar" }

        basic.request(method, path, options)

        expect(request_stub)
          .to.have.been.calledWith(method, "#{endpoint}#{path}", options)

      it "includes Basic Authorization header", sinon.test ->
        endpoint = "http://example.com"
        username = "username"
        password = "password"
        basic = create_basic(
          endpoint: endpoint
          username: username
          password: password
        )
        method = "GET"
        path = "/path"
        options = { foo: "bar" }

        basic.request(method, path, options)

        expect(options.headers).to.have.key("Authorization")
        expect(options.headers.Authorization)
          .to.equal("Basic dXNlcm5hbWU6cGFzc3dvcmQ=")
