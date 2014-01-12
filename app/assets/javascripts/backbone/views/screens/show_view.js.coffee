VanderlandenDemo.Views.Screens ||= {}

class VanderlandenDemo.Views.Screens.ShowView extends Backbone.View
  template: JST["backbone/templates/screens/show"]

  loadSVG: ->
    @model.load_svg_document().done (data) =>
      @d3.node().appendChild(data)
      #@d3.select('text').attr('fill','#D8D8D8')
      @create_logic_step_views(@model.logistics_steps)
      @randomEvents()

  randomEvents: ->
    do triggerCounters = =>
      ups = @.$('text#process_up tspan')
      downs = @.$('text#process_down tspan')
      ups_rand = Math.round(Math.random() * ups.size())
      downs_rand = Math.round(Math.random() * downs.size())
      d3.select(ups[ups_rand]).text(Math.ceil(Math.random() * 90))
      d3.select(downs[downs_rand]).text(Math.ceil(Math.random() * 90))
      setTimeout triggerCounters, 500

    do triggerSteps = =>
      step_rand = Math.round(Math.random() * (@model.logistics_steps.size() - 1))

      old_states = @model.logistics_steps
        .filter (s) -> 
          s.get('state') != ''
      _.each old_states, (step) =>
        step.set('state','')
        
      console.log(step_rand)
      states = ['alert','success','warning']
      @model.logistics_steps.at(step_rand).set('state',states[Math.floor(Math.random() * states.length)])
      setTimeout triggerSteps, 6000

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
