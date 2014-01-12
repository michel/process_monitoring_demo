VanderlandenDemo.Views.Screens ||= {}

class VanderlandenDemo.Views.Screens.ShowView extends Backbone.View
  template: JST["backbone/templates/screens/show"]

  loadSVG: ->
    @model.load_svg_document().done (data) =>
      @d3.node().appendChild(data)
      @create_logic_step_views(@model.logistics_steps)

  create_logic_step_views: (steps) ->
    steps.each (step) =>
      view = new VanderlandenDemo.Views.Screens.LogicStep model: step, el: @d3.select("##{step.get('node_name')}")[0][0]
      view.render()

  updateWindow: =>
    @d3.attr("width", $(document).width()).attr("height", $(document).height())

  render: ->
    $(@el).html(@template(@model.toJSON()))
    @d3 = d3.select(@.$('svg')[0])
    @loadSVG()
    window.onresize = @updateWindow
    return this
