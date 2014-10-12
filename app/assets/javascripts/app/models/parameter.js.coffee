define ["backbone"], (Backbone) ->
  class Parameter extends Backbone.Model
    defaults:
      name: ""
      value: ""
      active: false
