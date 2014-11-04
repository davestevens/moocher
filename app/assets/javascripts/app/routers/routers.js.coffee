define [
  "app/routers/connections_router",
  "app/routers/requests_router",
], (ConnectionsRouter, RequestsRouter) ->
  connections_router: new ConnectionsRouter()
  requests_router: new RequestsRouter()
