define ["jquery", "underscore"], ($, _) ->
  class ConnectionObject
    request: (method, path, options = {}) ->
      settings = _.extend({
        type: method,
        url: path,
        data: options.parameters
      }, _.omit(options, "parameters"))

      $.ajax(settings)
