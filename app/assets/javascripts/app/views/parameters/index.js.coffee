define [
  "marionette",
  "app/views/parameters/parameter",
  "text!app/templates/parameters/index.html"
], (Marionette, ParameterView, Template) ->
  class ParametersView extends Marionette.CompositeView
    template: _.template(Template)

    childView: ParameterView

    childViewContainer: ".list"

    events:
      "click .js-add": -> @collection.create({})

    collectionEvents:
      "sync": -> @model.trigger("change")
