define [
  "backbone",
  "app/models/connections/no_auth",
  "app/models/connections/oauth2"
], (Backbone, NoAuth, OAuth2) ->
  class Connections extends Backbone.Collection
    parse: (response, _options) ->
      _(response).map((attributes) ->
        switch attributes.type
          when "no_auth" then new NoAuth(attributes)
          when "oauth2" then new OAuth2(attributes)
      )

    url: -> "/connections"

    local: true
