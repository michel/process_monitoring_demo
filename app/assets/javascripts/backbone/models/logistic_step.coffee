class VanderlandenDemo.Models.LogisticStep extends Backbone.Model
  initialize: ->
    do randomCounters = =>
      in_rand = Math.round(Math.random() * 100)
      out_rand = Math.round(Math.random() * 100)
      @.set('count_in',in_rand)
      @.set('count_out',out_rand)
      setTimeout randomCounters, 1000

class VanderlandenDemo.Collections.LogisticStepCollection extends Backbone.Collection
  model: VanderlandenDemo.Models.LogisticStep
  
