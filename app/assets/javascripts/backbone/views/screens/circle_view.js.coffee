VanderlandenDemo.Views.Screens ||= {}

class VanderlandenDemo.Views.Screens.CircleView extends Backbone.View
  events:
    click: 'derp'

  initialize: ->
    @d3 = d3.select(@el)

  render: -> 
    cx = Math.random() * 200
    cy = Math.random() * 200
    r = Math.random() * 50
    @d3.attr("cx", cx).attr("cy", cy).attr("r", r)
    console.log(@el)
  derp: (e) ->
    console.log('derp')
    e.preventDefault()
    false
