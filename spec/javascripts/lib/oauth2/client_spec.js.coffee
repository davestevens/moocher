define ["app/lib/oauth2/client"], (Client) ->
  describe "Lib / OAuth2 / Client", ->
    describe "#id", ->
      it "returns the id given on initialization", ->
        id = "id"

        result = new Client(id: id).id

        expect(result).to.equal(id)

    describe "#secret", ->
      it "returns the secret given on initialization", ->
        secret = "secret"

        result = new Client(secret: secret).secret

        expect(result).to.equal(secret)

    describe "#endpoint", ->
      it "returns the endpoint given on initialization", ->
        endpoint = "http://example.com"

        result = new Client(endpoint: endpoint).endpoint

        expect(result).to.equal(endpoint)

    describe "#token_path", ->
      it "defaults to '/oauth/token'", ->
        result = new Client({}).token_path

        expect(result).to.equal("/oauth/token")

      context "when passed on initialization", ->
        it "returns the token_path given on initialization", ->
          token_path = "/token/path"

          result = new Client(token_path: token_path).token_path

          expect(result).to.equal(token_path)

    describe "#get_token", ->
      context "when using a proxy", ->
        it "makes a synchronous request through proxy", sinon.test ->
          token_path = "/token/path"
          endpoint = "http://example.com"
          client = new Client(endpoint: endpoint, token_path: token_path)

          client.get_token({})

          request = @requests[0]
          expect(request.async).to.be.false
          expect(request.method).to.equal("POST")
          expect(request.url).to.equal("#{endpoint}#{token_path}")

      context "when not using a proxy", sinon.test ->
        it "makes a synchronous request", sinon.test ->
          endpoint = "http://example.com"
          proxy_settings =
            path: "/proxy"
            type: "POST"
          client = new Client(endpoint: endpoint, proxy: proxy_settings)

          client.get_token({})

          request = @requests[0]
          expect(request.async).to.be.false
          expect(request.method).to.equal(proxy_settings.type)
          expect(request.url).to.equal(proxy_settings.path)

      xit "passes headers and parametes to request", sinon.test ->
        endpoint = "http://example.com"
        client = new Client(endpoint: endpoint)
        headers = { foo: "bar" }
        parameters = { bish: "bosh" }

        client.get_token(headers: headers, parameters: parameters)

        request = @requests[0]
        # TODO: check that request.requestBody includes headers, parameters,
        # method, endpoint, path

    describe "#request", ->
      context "when using a proxy", ->
        it "makes an asynchronous request through proxy", sinon.test ->
          proxy_settings =
            path: "/proxy"
            type: "POST"
          method = "GET"
          path = "/request_path"
          headers = { foo: "bar" }
          parameters = { bish: "bosh" }
          endpoint = "http://example.com"
          client = new Client(endpoint: endpoint, proxy: proxy_settings)

          client.request(method, path, headers: headers, parameters: parameters)

          request = @requests[0]
          expect(request.async).to.be.true
          expect(request.method).to.equal(proxy_settings.type)
          expect(request.url).to.equal(proxy_settings.path)
          # TODO: check that request.requestBody includes headers, parameters,
          # type & url

      context "when not using a proxy", ->
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
