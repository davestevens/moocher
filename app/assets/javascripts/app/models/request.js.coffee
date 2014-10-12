define [
  "backbone",
  "app/collections/parameters"
], (Backbone, Parameters) ->
  class Request extends Backbone.Model
    defaults:
      name: ""
      access_token_id: null
      path: "/"
      method: "GET"
      header_ids: []
      parameter_ids: []

    push: (attribute, value) ->
      array = _.clone(@get(attribute))
      array.push(value)
      @save(attribute, array)

    splice: (attribute, value) ->
      array = _.clone(@get(attribute))
      @save(attribute, _.without(array, value))

    options: ->
      headers: @_parameters("header")
      parameters: @_parameters("parameter")

    # private

    _parameters: (type) ->
      parameters = @_parameters_collection().selection(@get("#{type}_ids"))
      @_parameters_to_hash(parameters)

    _parameters_collection: ->
      parameters = new Parameters()
      parameters.fetch()
      parameters

    _parameters_to_hash: (parameters) ->
      _.chain(parameters)
        .filter((model) -> model.get("active"))
        .map((model) -> [model.get("name"), model.get("value")])
        .object()
        .value()
