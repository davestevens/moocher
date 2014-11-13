define ["backbone"], (Backbone) ->
  class Response extends Backbone.Model
    defaults:
      method: ""
      url: ""
      status: ""
      request_headers: ""
      request_body: ""
      response_headers: ""
      body: ""
