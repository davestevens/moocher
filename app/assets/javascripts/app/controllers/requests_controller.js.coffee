define [
  "app/models/request",
  "app/collections/requests",
  "app/views/requests/index",
  "app/views/requests/show",
  "app/views/requests/delete"
], (Request, Requests, IndexView, ShowView, DeleteView) ->
  index: ->
    requests = new Requests()
    requests.fetch()
    @view = new IndexView(collection: requests)

  new: ->
    requests = new Requests()
    request = requests.create({})
    window.location.hash = "#requests/#{request.id}"

  show: (id) ->
    requests = new Requests()
    requests.fetch()
    request = requests.get(id)
    @view = new ShowView(model: request)

  delete: (id) ->
    requests = new Requests()
    requests.fetch()
    request = requests.get(id)
    @view = new DeleteView(model: request)
