define [
  "marionette",
  "app/collections/access_tokens",
  "text!app/templates/requests/edit.html"
], (Marionette, AccessTokens, Template) ->
  class RequestsEditView extends Marionette.ItemView
    template: (serialized_model) =>
      attributes = _.extend(serialized_model, access_tokens: @_access_tokens())
      _.template(Template, attributes)

    events:
      "keyup input:text": "update_attribute"
      "change select": "update_attribute"

    update_attribute: (event) ->
      options = {}
      options[event.target.dataset.attribute] = event.target.value
      @model.save(options)

    _access_tokens: ->
      access_tokens = new AccessTokens()
      access_tokens.fetch()
      access_tokens.map((access_token) -> access_token.pick("id", "name"))
