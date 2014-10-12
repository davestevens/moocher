define [
  "backbone",
  "underscore",
  "jquery"
], (Backbone, _, $) ->
  class Errors
    constructor: (attributes) ->
      @attributes = attributes
      @errors = {}

    validate_blank: (keys...) ->
      _.each(keys, (key) => @add(key, @blank_error) if @blank(@attributes[key]))
    blank: (value) -> _.isEmpty($.trim(value))
    blank_error: "can't be blank"

    validate_inclusion: (key, array) ->
      @add("strategy", @inclusion_error) if @excludes(@attributes[key], array)
    excludes: (value, array) -> array.indexOf(value) == -1
    inclusion_error: "is not includes in the list"

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
      endpoint: null
      access_token: null
      expires_at: null
      refresh_token: null
      token_type: "bearer"

    validate: (attrs, options) ->
      errors = new Errors(attrs)
      errors.validate_blank("client_id", "client_secret", "endpoint")
      errors.validate_inclusion("strategy", _.keys(@strategies))
      errors.result()

    strategies:
      client_credentials: "Client Credentials"
      password: "Password"
