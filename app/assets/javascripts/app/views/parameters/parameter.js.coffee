define [
  "marionette"
  "text!app/templates/parameters/parameter.html"
], (Marionette, Template) ->
  class ParameterView extends Marionette.ItemView
    events:
      "keyup input:text": "update_attribute"
      "change input:checkbox": "update_checkbox"
      "click #js-remove": "remove_parameter"

    template: _.template(Template)

    initialize: (options) ->
      @request = options.request
      @type = options.type

    update_attribute: (event) ->
      options = {}
      options[event.target.dataset.attribute] = event.target.value
      @model.save(options)

    update_checkbox: (event) ->
      options = {}
      options[event.target.dataset.attribute] = event.target.checked
      @model.save(options)

    remove_parameter: ->
      @request.splice("#{@type}_ids", @model.id)
      @model.destroy()
