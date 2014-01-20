VanderlandenDemo.Views.Screens ||= {}

class VanderlandenDemo.Views.Screens.ShowView extends Backbone.View
  template: JST["backbone/templates/screens/show"]

  loadSVG: ->
    dfd = new jQuery.Deferred()

    @model.load_svg_document().done (data) =>
      @.$('#svg_container').append(data)
      @d3 = d3.select(@.$('svg')[0])
      @bargraph = new VanderlandenDemo.Views.Screens.BarGraphView(model: @model.logistics_steps.at(0))
      @create_logic_step_views(@model.logistics_steps)
      
      @randomEvents()
      element = $(document)
      @d3.attr 'viewBox',null
      @d3.attr "width", null
      @d3.attr "height", null
      dfd.resolve()
    return dfd.promise()

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
        
      states = ['alert','success','warning']
      @model.logistics_steps.at(step_rand).set('state',states[Math.floor(Math.random() * states.length)])
      setTimeout triggerSteps, 6000

     pathCounter = 1
     do animatePaths = =>
        @animatePath('#follow',pathCounter)
        @animatePath('#follow2',pathCounter)
        pathCounter += 1
        setTimeout animatePaths, Math.round(Math.random() * (2000))

  create_logic_step_views: (steps) ->
    steps.each (step) =>
      view = new VanderlandenDemo.Views.Screens.LogicStep model: step, el: @d3.select("##{step.get('node_name')}")[0][0], bargraph: @bargraph
      view.render()

  updateWindow: =>
    @d3.attr("width", $(document).width()).attr("height", $(document).height())

  animatePath: (path,pathCount) ->
    group = @d3.append("svg:g")
    targetPath = @d3.selectAll(path)
    pathNode = targetPath.node()
    pathLength = pathNode.getTotalLength()
    circle = group.append("circle").attr(
      r: 5
      fill: ->
        "hsl(" + Math.random() * 360 + ", 100%, 75%)"
      transform: ->
        p = pathNode.getPointAtLength(0)
        "translate(" + [p.x, p.y] + ")"
    )

    # Animate the circle:
    duration = 10000
    circle.transition().duration(duration).ease("linear").attrTween "transform", (d, i) ->
      (t) ->
        p = pathNode.getPointAtLength(pathLength * t)
        "translate(" + [p.x, p.y] + ")"
    .each "end", =>
      group.remove()
      @d3.select('#counter1 tspan').text(pathCount)

  render: ->
    $(@el).html(@template(@model.toJSON()))
    $.when(@loadSVG()).then =>
      @.$("#bar").html(@bargraph.render().el)

    return this
