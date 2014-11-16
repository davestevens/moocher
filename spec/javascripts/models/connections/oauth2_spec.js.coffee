define ["app/models/connections/oauth2", "backbone"], (OAuth2, Backbone) ->
  describe "Models / Connections / OAuth2", ->
    create_oauth2 = (attributes = {}, options = {}) ->
      new OAuth2(attributes, options)

    it "is a Backbone model", ->
      oauth2 = create_oauth2()

      expect(oauth2).to.be.an.instanceOf(Backbone.Model)

    it "has default attributes", ->
      oauth2 = create_oauth2()

      expect(oauth2.get("name")).to.equal("")
      expect(oauth2.get("endpoint")).to.be.null
      expect(oauth2.get("client_id")).to.be.null
      expect(oauth2.get("client_secret")).to.be.null

      expect(oauth2.get("strategy")).to.be.null

      expect(oauth2.get("username")).to.be.null
      expect(oauth2.get("password")).to.be.null
      expect(oauth2.get("access_token")).to.be.null
      expect(oauth2.get("expires_at")).to.be.null
      expect(oauth2.get("refresh_token")).to.be.null
      expect(oauth2.get("token_type")).to.equal("bearer")

      expect(oauth2.get("type")).to.equal("oauth2")

    describe "validations", ->
      valid_attributes =
        endpoint: "endpoint"
        client_id: "client_id"
        client_secret: "client_secret"
        strategy: "client_credentials"

      context "with Strategy not in the allowed list", ->
        it "is invalid", ->
          oauth2 = create_oauth2(valid_attributes)
          oauth2.set(strategy: "invalid strategy")

          result = oauth2.isValid()

          expect(result).to.be.false
          expect(oauth2.validationError).to.contain.key("strategy")

      context "with Strategy in the allowed list", ->
        it "is valid", ->
          oauth2 = create_oauth2(valid_attributes)
          oauth2.set(strategy: "client_credentials")

          result = oauth2.isValid()

          expect(result).to.be.true

      context "with a blank client_id", ->
        it "is invalid", ->
          oauth2 = create_oauth2(valid_attributes)
          oauth2.set(client_id: "")

          result = oauth2.isValid()

          expect(result).to.be.false
          expect(oauth2.validationError).to.contain.key("client_id")

      context "with a blank client_secret", ->
        it "is invalid", ->
          oauth2 = create_oauth2(valid_attributes)
          oauth2.set(client_secret: "")

          result = oauth2.isValid()

          expect(result).to.be.false
          expect(oauth2.validationError).to.contain.key("client_secret")

      context "with a blank endpoint", ->
        it "is invalid", ->
          oauth2 = create_oauth2(valid_attributes)
          oauth2.set(endpoint: "")

          result = oauth2.isValid()

          expect(result).to.be.false
          expect(oauth2.validationError).to.contain.key("endpoint")

      describe "Password Strategy", ->
        valid_password_attributes =
          endpoint: "endpoint"
          client_id: "client_id"
          client_secret: "client_secret"
          strategy: "password"
          username: "username"
          password: "password"

        context "with a blank username", ->
          it "is invalid", ->
            oauth2 = create_oauth2(valid_password_attributes)
            oauth2.set(username: "")

            result = oauth2.isValid()

            expect(result).to.be.false
            expect(oauth2.validationError).to.contain.key("username")

        context "with a blank password", ->
          it "is invalid", ->
            oauth2 = create_oauth2(valid_password_attributes)
            oauth2.set(password: "")

            result = oauth2.isValid()

            expect(result).to.be.false
            expect(oauth2.validationError).to.contain.key("password")

    describe ".strategies", ->
      it "is a hash of available OAuth2 Strategies", ->
        oauth2 = create_oauth2()

        result = oauth2.strategies

        expect(result).to.have.keys("client_credentials", "password")

    describe "#access_token", ->
      it "builds an OAuth2 AccessToken from the current Model", sinon.test ->
        oauth2 = create_oauth2()
        strategy = new Object(token_from_hash: $.noop)
        @spy(strategy, "token_from_hash")
        @stub(oauth2, "_strategy", -> strategy)

        oauth2.access_token()

        expect(strategy.token_from_hash).to.have.been.called

    describe "#request", ->
      it "makes a request through a Proxy", sinon.test ->
        proxy = { request: -> }
        request_stub = @stub(proxy, "request")
        endpoint = "http://example.com"
        oauth2 = create_oauth2(
          { endpoint: endpoint, strategy: "client_credentials" }
          { proxy: proxy }
        )
        method = "GET"
        path = "/path"
        options = { foo: "bar" }

        oauth2.request(method, path, options)

        expect(request_stub)
          .to.have.been.calledWith(method, "#{endpoint}#{path}", options)

    describe "#refresh", ->
      it "refreshes the OAuth2 AccessToken", sinon.test ->
        oauth2 = create_oauth2()
        token = new Object(refresh: $.noop)
        @spy(token, "refresh")
        @stub(oauth2, "access_token", -> token)

        oauth2.refresh()

        expect(token.refresh).to.have.been.called

      it "saves the new OAuth2 AccessToken attributes", sinon.test ->
        oauth2 = create_oauth2()
        token = new Object(
          refresh: ->
          access_token: "access_token"
          refresh_token: "refresh_token"
        )
        @stub(oauth2, "access_token", -> token)
        @spy(oauth2, "save")

        oauth2.refresh()

        expect(oauth2.save).to.have.been.calledWith
          access_token: "access_token"
          refresh_token: "refresh_token"

    describe "#validate_access_token", ->
      it "builds a new OAuth2 AccessToken from the current Model", sinon.test ->
        oauth2 = create_oauth2()
        strategy = new Object(get_token: -> new Object())
        @spy(strategy, "get_token")
        @stub(oauth2, "_strategy", -> strategy)

        oauth2.validate_access_token()

        expect(strategy.get_token).to.have.been.called

      it "saves the new OAuth2 AccessToken attributes", sinon.test ->
        oauth2 = create_oauth2()
        strategy = new Object(get_token: $.noop)
        token = new Object(
          access_token: "access_token"
          refresh_token: "refresh_token"
        )
        @stub(strategy, "get_token", -> token)
        @stub(oauth2, "_strategy", -> strategy)
        @spy(oauth2, "save")

        oauth2.validate_access_token()

        expect(oauth2.save).to.have.been.calledWith
          access_token: "access_token"
          refresh_token: "refresh_token"
