define [
  "marionette",
  "underscore",
  "text!app/templates/responses/show.html"
], (Marionette, _, Template) ->
  class ResponseView extends Marionette.ItemView
    template: (model) ->
      attributes =
        title: "#{model.method.toUpperCase()}: #{model.url} (#{model.status})"
        method: model.method.toUpperCase()
        request_headers: JSON.stringify(model.request_headers, null, "  ")
        request_body: JSON.stringify(model.request_body, null, "  ")
        body: JSON.stringify(model.body, null, "  ")

      _.template(Template, _.extend(model, attributes))

    modelEvents: -> { "change": @render }
