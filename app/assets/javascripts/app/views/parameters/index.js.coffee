define [
  "marionette",
  "app/views/parameters/parameter",
  "text!app/templates/parameters/index.html"
], (Marionette, ParameterView, Template) ->
  class ParametersView extends Marionette.CompositeView
    template: _.template(Template)

    initialize: (options) -> @type = options.type

    childView: ParameterView

    childViewOptions: -> { request: @model, type: @type }

    childViewContainer: ".list"

    events: { "click #js-add": "add" }

    add: (event) ->
      model = @collection.create({})
      @model.push("#{@type}_ids", model.id)
