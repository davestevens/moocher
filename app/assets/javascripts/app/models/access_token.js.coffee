define [
  "backbone",
  "underscore",
  "jquery"
], (Backbone, _, $) ->
  class Errors
    constructor: (attributes) ->
      @attributes = attributes
      @errors = {}

    check_blank: (keys...) ->
      _.each(keys, (key) => @add(key, @blank_error) if @blank(@attributes[key]))
    blank: (value) -> _.isEmpty($.trim(value))
    blank_error: "can't be blank"

    add: (key, value) ->
      @errors[key] ||= []
      @errors[key].push(value)

    result: -> !_.isEmpty(@errors) && @errors

  class AccessToken extends Backbone.Model
    defaults:
      name: ""
      strategy: null
      client_id: null
      client_secret: null
      access_token: null
      expires_at: null
      refresh_token: null
      token_type: "bearer"

    validate: (attrs, options) ->
      errors = new Errors(attrs)
      errors.check_blank("strategy", "client_id", "client_secret")
      errors.result()

    _blank_error: "can't be blank"

    _blank: (value) -> _.isEmpty($.trim(value))
