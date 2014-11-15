define ["backbone", "app/services/model_errors", "app/services/proxy"],
(Backbone, ModelErrors, Proxy) ->
  class NoAuth extends Backbone.Model
    defaults:
      name: ""
      endpoint: null
      type: "no_auth"

    validate: (attrs, options) ->
      errors = new ModelErrors(attrs)
      errors.validate_blank("endpoint")
      errors.result()

    request: (method, path, options = {}) ->
      @_proxy().request(method, "#{@get('endpoint')}/#{path}", options)

    # private

    _proxy: -> new Proxy()
