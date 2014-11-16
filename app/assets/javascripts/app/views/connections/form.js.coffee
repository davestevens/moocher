define [
  "marionette",
  "jquery",
  "app/services/connection_finder",
  "serialize-object"
], (Marionette, $, ConnectionFinder, _SerializeObject) ->
  class ConnectionsFormView extends Marionette.ItemView
    initialize: ->
      @listenTo(@model, "sync", @_sync)
      @listenTo(@model, "invalid", @_invalid)

    events: { "submit form": "_submit_form" }

    getTemplate: ->
      _.template(ConnectionFinder.form_template(@model.get("type")))

    templateHelpers: =>
      action: @action
      strategies: @model.strategies
      button: @button

    # private

    _submit_form: (event) ->
      event.preventDefault()
      @_create_model_from_form($(event.target))

    _create_model_from_form: ($form) ->
      @model.set($form.serializeObject())
      @collection.create(@model)

    _sync: -> window.location.hash = "#connections/#{@model.id}"

    _invalid: ->
      @_clear_form_errors()
      $errors = $("<div/>", class: "alert alert-danger",
      text: "Please review the problems below:")
      _.each(@model.validationError, (messages, attribute) =>
        @$("form .#{attribute}").addClass("has-error")
        @$("form .#{attribute} .controls")
          .append(@_error_messages(messages))
      )
      @$("form").prepend($errors)

    _clear_form_errors: ->
      @$("form").find(".alert").remove()
      @$("form").find(".form-group").removeClass("has-error")
      @$("form").find(".help-block").remove()

    _error_messages: (messages) ->
      $("<span/>", class: "help-block", text: messages.join("<br/>"))
