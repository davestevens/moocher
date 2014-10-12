define [
  "marionette",
  "jquery",
  "serialize-object",
  "text!app/templates/access_tokens/form.html"
], (Marionette, $, _SerializeObject, Template) ->
  class AccessTokensNewView extends Marionette.ItemView
    initialize: ->
      @listenTo(@model, "sync", @_sync)
      @listenTo(@model, "invalid", @_invalid)

    events: { "submit form": "_submit_form" }

    template: (serialized_model) =>
      attributes = _.extend(serialized_model, strategies: @model.strategies)
      _.template(Template, attributes)

    # private

    _submit_form: (event) ->
      event.preventDefault()
      @_create_model_from_form($(event.target))

    _create_model_from_form: ($form) ->
      @model.set($form.serializeObject())
      @collection.create(@model)

    _sync: -> window.location.hash = "#access_tokens/#{@model.id}"

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
