define ["app/lib/oauth2/token"], (Token) ->
  describe "Lib / OAuth2 / Token", ->
    describe ".client", ->
      it "returns to client given on initialization", ->
        client = new Object()

        result = new Token(client).client

        expect(result).to.equal(client)

    describe ".access_token", ->
      it "returns to access_token given on initialization", ->
        access_token = "access_token"

        result = new Token(null, access_token: access_token).access_token

        expect(result).to.equal(access_token)

    describe ".expires_at", ->
      context "when expires_at is passed", ->
        it "returns to 'expires_at' given on initialization", ->
          expires_at = 1234567890

          result = new Token(null, expires_at: expires_at).expires_at

          expect(result).to.equal(expires_at)

      context "when 'expires_in' is passed", ->
        it "calculates 'expires_at' time", sinon.test ->
          expires_in = 15
          expires_at = 16000
          @clock.tick(1000)

          result = new Token(null, expires_in: expires_in).expires_at

          expect(result).to.equal(expires_at)

    describe ".refresh_token", ->
      it "returns to refresh_token given on initialization", ->
        refresh_token = "refresh_token"

        result = new Token(null, refresh_token: refresh_token).refresh_token

        expect(result).to.equal(refresh_token)

    describe ".token_type", ->
      it "returns to token_type given on initialization", ->
        token_type = "token_type"

        result = new Token(null, token_type: token_type).token_type

        expect(result).to.equal(token_type)

    describe "#set_data", ->
      describe "#access_token", ->
        it "sets @access_token with value passed", ->
          access_token = "access_token"
          token = new Token()

          token.set_data(access_token: access_token)
          result = token.access_token

          expect(result).to.equal(access_token)

      describe "#expires_at", ->
        context "when expires_at is passed", ->
          it "sets @expires_at with passed value", ->
            expires_at = 1234567890
            token = new Token()

            token.set_data(expires_at: expires_at)
            result = token.expires_at

            expect(result).to.equal(expires_at)

        context "when 'expires_in' is passed", ->
          it "calculates @expires_at time", sinon.test ->
            expires_in = 15
            expires_at = 16000
            @clock.tick(1000)
            token = new Token()

            token.set_data(expires_in: expires_in)
            result = token.expires_at

            expect(result).to.equal(expires_at)

      describe "#refresh_token", ->
        it "returns to refresh_token given on initialization", ->
          refresh_token = "refresh_token"
          token = new Token()

          token.set_data(refresh_token: refresh_token)
          result = token.refresh_token

          expect(result).to.equal(refresh_token)

      describe "#token_type", ->
        it "returns to token_type given on initialization", ->
          token_type = "token_type"
          token = new Token()

          token.set_data(token_type: token_type)
          result = token.token_type

          expect(result).to.equal(token_type)

    describe "#request", ->
      context "when Token has expired", ->
        it "attempts to refresh the token before making request", sinon.test ->
          client = new Object
            request: $.noop
            get_token: -> { responseJSON: "responseJSON" }
          @stub(client, "request")
          token = new Token(client, expires_in: 0)
          @stub(token, "refresh")

          token.request("GET", "/path")

          expect(token.refresh).to.have.been.called
          expect(client.request).to.have.been.calledWith("GET", "/path")

      context "when Token has not expired", ->
        it "make a request through the Client", sinon.test ->
          client = new Object(request: $.noop)
          @stub(client, "request")
          token = new Token(client, expires_in: 15)

          token.request("GET", "/path")

          expect(client.request).to.have.been.calledWith("GET", "/path")

    describe "#get", ->
      it "makes GET request", sinon.test ->
        token = new Token()
        @stub(token, "request")
        path = "/some/path"
        options = { header: {}, parameters: {} }

        token.get(path, options)

        expect(token.request).to.have.been.calledWith("GET", path, options)

    describe "#post", ->
      xit "makes POST request", ->

    describe "#put", ->
      xit "makes PUT request", ->

    describe "#delete", ->
      xit "makes DELETE request", ->

    describe "#refresh", ->
      it "request a refresh token from @client", sinon.test ->
        client = new Object(get_token: -> { responseJSON: "responseJSON" })
        token = new Token(client)
        @spy(client, "get_token")

        refresh_parameters = "refresh_parameters"
        @stub(token, "refresh_parameters", -> refresh_parameters)

        token.refresh()

        expect(client.get_token)
          .to.have.been.calledWith(parameters: refresh_parameters)

      it "updates @token with returned data", sinon.test ->
        token_data = "token_data"
        client = new Object(get_token: -> { responseJSON: token_data })
        token = new Token(client)
        @stub(token, "refresh_parameters")
        @stub(token, "set_data")

        token.refresh()

        expect(token.set_data).to.have.been.calledWith(token_data)

    describe "#refresh_parameters", ->
      it "throws error", ->
        token = new Token()

        expect(-> token.refresh_parameters())
          .to.throw(Error, "Cannot refresh Token")

    describe "#has_expired", ->
      context "when current time is equal to @expires_at", ->
        it "is true", sinon.test ->
          token = new Token(null, expires_at: 15)
          @clock.tick(15)

          result = token.has_expired()

          expect(result).to.be.true

      context "when current time is greater than @expires_at", ->
        it "is true", sinon.test ->
          token = new Token(null, expires_at: 15)
          @clock.tick(16)

          result = token.has_expired()

          expect(result).to.be.true

      context "when current time is less than @expires_at", ->
        it "is false", sinon.test ->
          token = new Token(null, expires_at: 15)
          @clock.tick(14)

          result = token.has_expired()

          expect(result).to.be.false
