define [
  "marionette",
  "jquery",
  "serialize-object",
], (Marionette, $, _SerializeObject) ->
  class FormItemView extends Marionette.ItemView
    initialize: ->
      @listenTo(@model, "sync", @_sync)
      @listenTo(@model, "invalid", @_invalid)

    events: { "submit form": "_submit_form" }

    template: (serialized_model) =>
      attributes = _.extend(serialized_model, @_template_extras())
      _.template(@form_template, attributes)

    form_template: $.noop

    # private
    _template_extras: ->
      strategies: @model.strategies
      action: @action
      button: @button

    _submit_form: (event) ->
      event.preventDefault()
      @_create_model_from_form($(event.target))

    _create_model_from_form: ($form) ->
      @model.set($form.serializeObject())
      @collection.create(@model)

    _sync: -> window.location.hash = "##{@route}/#{@model.id}"

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
