define [
  "marionette",
  "text!app/templates/requests/show.html",
  "app/views/requests/edit",
  "app/collections/access_tokens",
  "app/collections/parameters",
  "app/views/parameters/index",
  "app/models/response",
  "app/views/responses/show"
], (Marionette, Template, RequestsEditView, AccessTokens, Parameters,
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
      collection = new Parameters()
      collection.fetch()

      _headers = collection.selection(@model.get("header_ids"))
      headers = new Parameters(_headers)
      view = new ParametersIndexView(
        type: "header"
        collection: headers
        model: @model
      )
      @headers.show(view)

    render_parameters: ->
      collection = new Parameters()
      collection.fetch()

      _parameters = collection.selection(@model.get("parameter_ids"))
      parameters = new Parameters(_parameters)
      view = new ParametersIndexView(
        type: "parameter"
        collection: parameters
        model: @model
      )
      @parameters.show(view)

    render_response: ->
      @response_model = new Response()
      view = new ResponseView(model: @response_model)
      @response.show(view)

    make_request: (event) ->
      event.preventDefault()

      token_model = @_get_access_token(@model.get("access_token_id"))
      options = @model.options()
      token_model.request(@model.get("method"), @model.get("path"), options)
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
    _get_access_token: (id) ->
      access_tokens = new AccessTokens()
      access_tokens.fetch()
      access_tokens.get(id)
