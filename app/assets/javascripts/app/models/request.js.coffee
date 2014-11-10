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
      headers: new Parameters()
      parameters: new Parameters()
      encoding: "form"

    parse: (response, _options) ->
      _.tap(response, (r) =>
        r.headers = @_create_collection("headers", r.headers)
        r.parameters = @_create_collection("parameters", r.parameters)
      )

    toJSON: ->
      _.tap(_.clone(@attributes), (attrs) ->
        attrs.headers = attrs.headers.pluck("id")
        attrs.parameters = attrs.parameters.pluck("id")
      )

    options: ->
      headers: @_parameters_to_hash("headers")
      parameters: @_set_encoding(@_parameters_to_hash("parameters"))

    # private

    # Create new Backbone.Collection or return current
    _create_collection: (attribute, value) ->
      if @get(attribute) instanceof Backbone.Collection
        @get(attribute)
      else
        params = new Parameters()
        params.fetch()
        new Parameters(params.selection(value))

    _parameters_to_hash: (type) ->
      parameters = @get(type)
      _.chain(parameters.where(active: true))
        .map((model) -> [model.get("name"), model.get("value")])
        .object()
        .value()

    _set_encoding: (hash) ->
      return $.param(hash) if @get("encoding") == "form"
      hash
