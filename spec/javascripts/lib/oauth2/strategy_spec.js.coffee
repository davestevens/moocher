define [
  "app/lib/oauth2/strategy",
  "app/lib/oauth2/token"
], (Strategy, Token) ->
  describe "Lib / OAuth2 / Strategy", ->
    before ->
      @create_token_hash = ->
        access_token: "access_token"
        refresh_token: "refresh_token"
        expires_at: 1234567890
        token_type: "token_type"

    describe ".client", ->
      it "returns to client given on initialization", ->
        client = new Object()

        result = new Strategy(client: client).client

        expect(result).to.equal(client)

    describe ".token", ->
      context "when passed", ->
        it "returns to token given on initialization", ->
          token = new Object()

          result = new Strategy(token: token).token

          expect(result).to.equal(token)

      context "when not passed", ->
        it "is an instance of Token class", ->
          result = new Strategy({}).token

          expect(result).to.be.an.instanceOf(Token)

    describe ".token_class", ->
      it "is 'Token'", ->
        result = new Strategy({}).token_class

        expect(result).to.equal(Token)

    describe "#parameters", ->
      it "is a noop", ->
        result = new Strategy({}).parameters

        expect(result).to.equal($.noop)

    describe "#get_token", ->
      it "builds parameters", sinon.test ->
        client = new Object(get_token: $.noop)
        @stub(client, "get_token", => { responseJSON: @create_token_hash() })
        strategy = new Strategy(client: client)
        @stub(strategy, "parameters")
        passed_parameters = "passed_parameters"

        result = strategy.get_token(passed_parameters)

        expect(strategy.parameters)
          .to.have.been.calledWith(passed_parameters)

      it "passes parameters to client", sinon.test ->
        client = new Object(get_token: $.noop)
        @stub(client, "get_token", => { responseJSON: @create_token_hash() })
        strategy = new Strategy(client: client, parameters: parameters)
        parameters = "parameters"
        @stub(strategy, "parameters", -> parameters)

        result = strategy.get_token()

        expect(client.get_token)
          .to.have.been.calledWith(parameters: parameters)

      it "requests a token from the client and builds a token", sinon.test ->
        token_hash = @create_token_hash()
        client = new Object(get_token: $.noop)
        @stub(client, "get_token", -> { responseJSON: token_hash })
        strategy = new Strategy(client: client)
        @spy(strategy, "token_from_hash")

        result = strategy.get_token()

        expect(client.get_token).to.have.been.called
        expect(strategy.token_from_hash).to.have.been.calledWith(token_hash)

    describe "#token_from_hash", ->
      it "returns a token from the passed hash", ->
        token = new Token()

        token_hash = @create_token_hash()

        strategy = new Strategy(token: token)
        result = strategy.token_from_hash(token_hash)

        expect(result).to.be.an.instanceOf(Token)
        expect(result.access_token).to.equal(token_hash.access_token)
        expect(result.refresh_token).to.equal(token_hash.refresh_token)
        expect(result.expires_at).to.equal(token_hash.expires_at)
        expect(result.token_type).to.equal(token_hash.token_type)
