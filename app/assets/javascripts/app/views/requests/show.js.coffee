define [
  "marionette",
  "text!app/templates/requests/show.html",
  "app/views/requests/edit",
  "app/collections/connections",
  "app/collections/parameters",
  "app/views/parameters/index",
  "app/models/response",
  "app/views/responses/show"
], (Marionette, Template, RequestsEditView, Connections, Parameters,
  ParametersIndexView, Response, ResponseView) ->
  class RequestView extends Marionette.LayoutView
    template: _.template(Template)

    events:
      "submit form": "make_request"

    onRender: ->
      @render_request()
      @render_headers()
      @render_parameters()
      @render_response()

    regions:
      request: "#js-request"
      headers: "#js-headers"
      parameters: "#js-parameters"
      response: "#js-response"

    render_request: ->
      view = new RequestsEditView(model: @model)
      @request.show(view)

    render_headers: ->
      view = new ParametersIndexView(
        collection: @model.get("headers")
        model: @model
      )
      @headers.show(view)

    render_parameters: ->
      view = new ParametersIndexView(
        collection: @model.get("parameters")
        model: @model
      )
      @parameters.show(view)

    render_response: ->
      @response_model = new Response()
      view = new ResponseView(model: @response_model)
      @response.show(view)

    make_request: (event) ->
      event.preventDefault()

      connection = @_get_connection(@model.get("connection_id"))
      options = @model.options()
      connection.request(@model.get("method"), @model.get("path"), options)
        .done( (data, status, xhr) =>
          @response_model.set
            method: @model.get("method")
            url: @model.get("path")
            status: "#{xhr.status} - #{status}"
            request_headers: options.headers
            request_body: options.parameters
            response_headers: xhr.getAllResponseHeaders()
            body: data
        )
        .fail( (xhr, _error, status) =>
          @response_model.set
            method: @model.get("method")
            url: @model.get("path")
            status: "#{xhr.status} - #{status}"
            request_headers: options.headers
            request_body: options.parameters
            response_headers: xhr.getAllResponseHeaders()
            body: xhr.responseJSON || xhr.responseText
        )

    # private
    _get_connection: (id) ->
      connections = new Connections()
      connections.fetch()
      connections.get(id)
