define [
  "backbone",
  "jquery",
  "app/collections/parameters"
], (Backbone, $, Parameters) ->
  class Request extends Backbone.Model
    defaults:
      name: ""
      connection_id: null
      path: "/"
      method: "GET"
      header_ids: []
      parameter_ids: []
      encoding: "form"

    push: (attribute, value) ->
      array = _.clone(@get(attribute))
      array.push(value)
      @save(attribute, array)

    splice: (attribute, value) ->
      array = _.clone(@get(attribute))
      @save(attribute, _.without(array, value))

    options: ->
      headers: @_parameters("header")
      parameters: @_set_encoding(@_parameters("parameter"))

    # private

    _parameters: (type) ->
      parameters = @_parameters_collection().selection(@get("#{type}_ids"))
      @_parameters_to_hash(parameters)

    _set_encoding: (hash) ->
      return $.param(hash) if @get("encoding") == "form"
      hash

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
