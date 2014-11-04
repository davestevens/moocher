define [
  "marionette",
  "app/collections/connections",
  "text!app/templates/requests/edit.html"
], (Marionette, Connections, Template) ->
  class RequestsEditView extends Marionette.ItemView
    template: (serialized_model) =>
      attributes = _.extend(serialized_model,
      connections: @_connections(), encodings: @_encodings)
      _.template(Template, attributes)

    events:
      "keyup input:text": "update_attribute"
      "change select": "update_attribute"

    update_attribute: (event) ->
      options = {}
      options[event.target.dataset.attribute] = event.target.value
      @model.save(options)

    _connections: ->
      connections = new Connections()
      connections.fetch()
      connections.map((connection) -> connection.pick("id", "name"))

    _encodings:
      [
        { value: "form", label: "Form-encoded" },
        { value: "json", label: "JSON-encoded" }
      ]