define ["backbone", "app/models/access_token"], (Backbone, AccessToken) ->
  class AccessTokens extends Backbone.Collection
    model: AccessToken

    url: -> "/access_tokens"

    local: true
