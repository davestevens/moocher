define [
  "marionette",
  "underscore",
  "text!app/templates/responses/show.html"
], (Marionette, _, Template) ->
  class ResponseView extends Marionette.ItemView
    template: (model) =>
      attributes =
        title: @_title_display(model)
        request_headers: @_request_headers_display(model.request_headers)
        request_body: JSON.stringify(model.request_body, null, "  ")
        response_body: JSON.stringify(model.body, null, "  ")

      _.template(Template, _.extend(model, attributes))

    modelEvents: -> { "change": @render }

    # private

    _title_display: (model) ->
      "#{model.method.toUpperCase()}: #{model.url} (#{model.status})"

    _request_headers_display: (headers) ->
      _.chain(headers)
        .map((value, key) -> "#{key}: #{value}")
        .join("\n")
        .value()
