define ["app/lib/oauth2/client"], (Client) ->
  describe "Lib / OAuth2 / Client", ->
    describe ".id", ->
      it "returns the id given on initialization", ->
        id = "id"

        result = new Client(id: id).id

        expect(result).to.equal(id)

    describe ".secret", ->
      it "returns the secret given on initialization", ->
        secret = "secret"

        result = new Client(secret: secret).secret

        expect(result).to.equal(secret)

    describe ".endpoint", ->
      it "returns the endpoint given on initialization", ->
        endpoint = "http://example.com"

        result = new Client(endpoint: endpoint).endpoint

        expect(result).to.equal(endpoint)

    describe ".token_path", ->
      it "returns the token_path given on initialization", ->
        token_path = "/token/path"

        result = new Client(token_path: token_path).token_path

        expect(result).to.equal(token_path)

      it "defaults to '/oauth/token'", ->
        result = new Client({}).token_path

        expect(result).to.equal("/oauth/token")

    describe ".connection", ->
      it "returns the connection given on initialization", ->
        connection = new Object()

        result = new Client(connection: connection).connection

        expect(result).to.equal(connection)

      context "when passed on initialization", ->
        it "returns the token_path given on initialization", ->
          token_path = "/token/path"

          result = new Client(token_path: token_path).token_path

          expect(result).to.equal(token_path)

    describe "#get_token", ->
      it "makes a synchronous request", sinon.test ->
        token_path = "/token/path"
        endpoint = "http://example.com"
        client = new Client(endpoint: endpoint, token_path: token_path)
        server_response(@server, "http://example.com/token/path")

        client.get_token({})

        request = @requests[0]
        expect(request.async).to.be.false
        expect(request.method).to.equal("POST")
        expect(request.url).to.equal("#{endpoint}#{token_path}")

      context "when request is unsuccessful", ->
        it "throws an error", sinon.test ->
          client = new Client(endpoint: "http://example.com")
          server_response(@server, "http://example.com/oauth/token", 401)

          expect(-> client.get_token()).to.throw(Error, "Unauthorized")

      it "passes headers and parametes to request", sinon.test ->
        endpoint = "http://example.com"
        client = new Client(endpoint: endpoint)
        headers = { foo: "bar" }
        parameters = { bish: "bosh" }
        server_response(@server, "http://example.com/oauth/token")

        client.get_token(headers: headers, parameters: parameters)

        request = @requests[0]
        expect(request.requestHeaders).to.include(headers)
        expect(request.requestBody).to.equal("bish=bosh")

      server_response = (server, url, status = 200) ->
        server.respondWith(
          "POST", url,
          [status, { "Content-Type": "application/json" }, "{}"]
        )

    describe "#request", ->
      it "makes an asynchronous request", sinon.test ->
        method = "GET"
        path = "/request_path"
        headers = { foo: "bar" }
        parameters = { bish: "bosh" }
        endpoint = "http://example.com"
        client = new Client(endpoint: endpoint)

        client.request(method, path, headers: headers, parameters: parameters)

        request = @requests[0]
        expect(request.async).to.be.true
        expect(request.method).to.equal(method)
        expect(request.url).to.equal("#{endpoint}#{path}?bish=bosh")
        expect(request.requestHeaders).to.include(headers)

    describe "#client_credentials", ->
      it "returns a ClientCredentials strategy", ->
        client_credentials = class ClientCredentials
        client = new Client(client_credentials: client_credentials)

        result = client.client_credentials()

        expect(result).to.be.an.instanceOf(client_credentials)

    describe "#password", ->
      it "returns a Password strategy", ->
        password = class Password
        client = new Client(password: password)

        result = client.password()

        expect(result).to.be.an.instanceOf(password)
