define ["backbone"], (Backbone) ->
  class Response extends Backbone.Model
    defaults:
      method: ""
      url: ""
      request_headers: ""
      status: ""
      response_headers: ""
      body: ""
