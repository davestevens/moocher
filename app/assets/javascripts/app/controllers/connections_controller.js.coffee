define [
  "app/models/connections/no_auth",
  "app/models/connections/oauth2",
  "app/collections/connections",
  "app/views/connections/index",
  "app/views/connections/new",
  "app/views/connections/show",
  "app/views/connections/edit",
  "app/views/connections/delete"
], (NoAuth, OAuth2, Connections, IndexView, NewView, ShowView, EditView,
  DeleteView) ->
  index: ->
    connections = new Connections()
    connections.fetch()
    @view = new IndexView(collection: connections)

  new: (type) ->
    types =
      no_auth: NoAuth
      oauth2: OAuth2
    connection = new types[type]()
    connections = new Connections()
    @view = new NewView(model: connection, collection: connections)

  show: (id) ->
    connections = new Connections()
    connections.fetch()
    connection = connections.get(id)
    @view = new ShowView(model: connection)

  edit: (id) ->
    connections = new Connections()
    connections.fetch()
    connection = connections.get(id)
    @view = new EditView(model: connection, collection: connections)

  delete: (id) ->
    connections = new Connections()
    connections.fetch()
    connection = connections.get(id)
    @view = new DeleteView(model: connection)
