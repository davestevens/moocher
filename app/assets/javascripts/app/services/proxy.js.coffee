define ["jquery"], ($) ->
  # Makes jQuery.ajax request through Proxy
  #
  # Passes headers and parameters to Proxy, all other options are passed to
  # jQuery.ajax object
  #
  class Proxy
    constructor: (options = {}) ->
      @url = options.url || "/proxy"
      @type = options.type || "post"

    request: (method, path, options = {}) ->
      settings = _.extend({
        type: @type
        url: @url
        data: @_request_options(method, path, options)
      }, _.omit(options, "headers", "parameters"))

      $.ajax(settings)

    # private

    _request_options: (method, path, options = {}) ->
      type: method
      url: path
      headers: options.headers
      data: options.parameters
