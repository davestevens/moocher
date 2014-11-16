define ["backbone", "app/services/model_errors", "app/services/proxy"],
(Backbone, ModelErrors, Proxy) ->
  class NoAuth extends Backbone.Model
    initialize: (attributes, options = {}) ->
      @proxy = options.proxy || new Proxy()

    defaults:
      name: ""
      endpoint: null
      username: null
      password: null
      type: "basic"

    validate: (attrs, options) ->
      errors = new ModelErrors(attrs)
      errors.validate_blank("endpoint", "username", "password")
      errors.result()

    request: (method, path, options = {}) ->
      options.headers = _.extend(@_headers(), options.headers)
      @proxy.request(method, "#{@get('endpoint')}#{path}", options)

    # private

    _headers: -> Authorization: "Basic #{@_authentication()}"

    _authentication: -> btoa("#{@get('username')}:#{@get('password')}")
