define [
  "app/models/access_token",
  "app/collections/access_tokens",
  "app/views/access_tokens/index",
  "app/views/access_tokens/new"
], (AccessToken, AccessTokens, IndexView, NewView) ->
  index: ->
    access_tokens = new AccessTokens()
    access_tokens.fetch()
    @view = new IndexView(collection: access_tokens)

  new: ->
    access_token = new AccessToken()
    access_tokens = new AccessTokens()
    @view = new NewView(model: access_token, collection: access_tokens)
