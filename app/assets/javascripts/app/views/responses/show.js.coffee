define ["marionette", "underscore", "text!app/templates/responses/show.html"],
(Marionette, _, Template) ->
  class ResponseView extends Marionette.ItemView
    template: _.template(Template)

    templateHelpers:
      escape: (input) -> _.escape(input)
      json_stringify: (input) -> JSON.stringify(input, null, "  ")
      title: -> "#{@method}: #{@url} (#{@status})"
      format_request_headers: ->
        _.map(@request_headers, (value, key) -> "#{key}: #{value}")
          .join("\n")

    modelEvents: -> { "change": @render }
