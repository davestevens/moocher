define ["backbone", "app/services/connection_finder"],
(Backbone, ConnectionFinder) ->
  class Connections extends Backbone.Collection
    parse: (response, _options) ->
      _(response).map((attributes) =>
        model = @_model_type(attributes.type)
        new model(attributes)
      )

    url: -> "/connections"

    local: true

    # private

    _model_type: (type) -> ConnectionFinder.model(type)
