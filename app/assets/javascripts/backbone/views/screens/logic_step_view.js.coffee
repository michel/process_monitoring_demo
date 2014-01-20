VanderlandenDemo.Views.Screens ||= {}

class VanderlandenDemo.Views.Screens.LogicStep extends Backbone.View
  events:
    click: 'select'
    mouseover: 'hover'

  initialize: ->
    @d3 = d3.select(@el)
    @d3.classed('logistic_step',true)
    @model.bind('change',@setState)
    @bargraph = @options.bargraph
    @drawSelectionBox()

  setState: =>
    @d3.classed('alert',@model.get('state') == 'alert')
    @d3.classed('warning',@model.get('state') == 'warning')
    @d3.classed('success',@model.get('state') == 'success')

  drawSelectionBox: ->
    box = this.d3[0][0].getBBox()
    @d3.append("rect")
    .attr("rx", 6)
    .attr("ry", 6)
    .attr("x", -10)
    .attr("y", -10)
    .attr("width", box.width + 20)
    .attr("height", box.height + 20)
    .attr("class",'selectionBox')

  hover: (e) ->
    d3.select(".hover").classed("hover",false)
    @d3.classed('hover',true)
    e.preventDefault()
    false

  select: (e) ->
    d3.select(".selected").classed("selected",false)
    @d3.classed('selected',true)
    @d3.classed('hover',false)
    @bargraph.model = @model
    @bargraph.render()
    e.preventDefault()

    false
