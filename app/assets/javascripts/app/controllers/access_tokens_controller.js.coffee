define [
  "app/models/access_token",
  "app/collections/access_tokens",
  "app/views/access_tokens/index",
  "app/views/access_tokens/new",
  "app/views/access_tokens/show",
  "app/views/access_tokens/edit",
], (AccessToken, AccessTokens, IndexView, NewView, ShowView, EditView) ->
  index: ->
    access_tokens = new AccessTokens()
    access_tokens.fetch()
    @view = new IndexView(collection: access_tokens)

  new: ->
    access_token = new AccessToken()
    access_tokens = new AccessTokens()
    @view = new NewView(model: access_token, collection: access_tokens)

  show: (id) ->
    access_tokens = new AccessTokens()
    access_tokens.fetch()
    access_token = access_tokens.get(id)
    @view = new ShowView(model: access_token)

  edit: (id) ->
    access_tokens = new AccessTokens()
    access_tokens.fetch()
    access_token = access_tokens.get(id)
    @view = new EditView(model: access_token, collection: access_tokens)
