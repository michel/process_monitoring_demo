class VanderlandenDemo.Models.Screen extends Backbone.Model
  paramRoot: 'screen'


  defaults:
    title: null
  
  initialize: ->
    @logistics_steps = new VanderlandenDemo.Collections.LogisticStepCollection

  create_logistic_steps: (document) ->
    _.each $(document).find("g[id^='logistics_step']"), (node) =>
      @logistics_steps.add node_name: $(node).attr('id')

  load_svg_document: ->
    dfd = new jQuery.Deferred()
    d3.xml "/assets/screens/#{@get('svg_file')}", 'image/svg+xml', (error, data) =>
      if error
        console.log('Error while loading the SVG file!', error)
        dfd.reject(error)
      else
        @create_logistic_steps(data.documentElement)
        dfd.resolve(data.documentElement)
    return dfd.promise()

class VanderlandenDemo.Collections.ScreensCollection extends Backbone.Collection
  model: VanderlandenDemo.Models.Screen
  url: '/screens'
