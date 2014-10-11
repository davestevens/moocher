define [
  "app/models/access_token",
  "app/collections/access_tokens",
  "app/views/access_tokens/index"
], (AccessToken, AccessTokens, IndexView) ->
  index: ->
    access_tokens = new AccessTokens()
    access_tokens.fetch()
    @view = new IndexView(collection: access_tokens)
