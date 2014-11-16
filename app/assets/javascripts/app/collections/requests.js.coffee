define ["backbone", "app/models/request"], (Backbone, Request) ->
  class Requests extends Backbone.Collection
    model: Request

    url: -> "/requests"

    local: true
