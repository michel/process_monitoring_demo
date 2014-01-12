VanderlandenDemo.Views.Screens ||= {}

class VanderlandenDemo.Views.Screens.LogicStep extends Backbone.View
  events:
    click: 'select'

  initialize: ->
    @d3 = d3.select(@el)
    @drawSelectionBox()

  drawSelectionBox: ->
    box = this.d3[0][0].getBBox()
    @d3.append("rect")
    .attr("rx", 6)
    .attr("ry", 6)
    .attr("x", -10)
    .attr("y", -10)
    .attr("width", box.width + 20)
    .attr("height", box.height + 10)
    .attr("class",'selectionBox')

  select: (e) ->
    $('svg .selected').removeAttr('class')
    @d3.attr('class','selected')
    e.preventDefault()
    false
