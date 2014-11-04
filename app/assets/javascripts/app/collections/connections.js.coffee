define ["backbone", "app/models/connection"], (Backbone, Connection) ->
  class Connections extends Backbone.Collection
    model: Connection

    url: -> "/connections"

    local: true
