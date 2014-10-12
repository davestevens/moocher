define ["backbone", "app/models/parameter"], (Backbone, Parameter) ->
  class Parameters extends Backbone.Collection
    model: Parameter

    url: -> "/parameters"

    local: true

    selection: (ids) -> @filter((model) -> _.contains(ids, model.id))
