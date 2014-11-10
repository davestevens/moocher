define [
  "marionette"
  "text!app/templates/parameters/parameter.html"
], (Marionette, Template) ->
  class ParameterView extends Marionette.ItemView
    events:
      "keyup input:text": "update_attribute"
      "change input:checkbox": "update_checkbox"
      "click .js-remove": -> @model.destroy()

    template: _.template(Template)

    update_attribute: (event) ->
      options = {}
      options[event.target.dataset.attribute] = event.target.value
      @model.save(options)

    update_checkbox: (event) ->
      options = {}
      options[event.target.dataset.attribute] = event.target.checked
      @model.save(options)
