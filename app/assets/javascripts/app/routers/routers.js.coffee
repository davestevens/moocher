define [
  "app/routers/access_tokens_router",
  "app/routers/requests_router",
], (AccessTokensRouter, RequestsRouter) ->
  access_tokens_router: new AccessTokensRouter()
  requests_router: new RequestsRouter()
