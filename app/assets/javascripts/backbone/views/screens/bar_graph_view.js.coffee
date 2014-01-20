VanderlandenDemo.Views.Screens ||= {}

class VanderlandenDemo.Views.Screens.BarGraphView extends Backbone.View
  template: JST["backbone/templates/screens/bar_graph"]

  initialize: ->
    if @model
      @model.bind('change',@render)

  render: =>
    if @model
      $(@el).html(@template(@model.toJSON()))
    #@d3.attr 'viewBox 375 81'
    #@d3.attr "width", null
    #@d3.attr "height", null
    return this
