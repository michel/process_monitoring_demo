class VanderlandenDemo.Routers.ScreensRouter extends Backbone.Router
  initialize: (options) ->
    @screens = new VanderlandenDemo.Collections.ScreensCollection()
    @screens.reset options.screens

  routes:
    "screen/:id"      : "show"
    ".*"        : "index"

  index: ->
    first_screen = @screens.first().get('id')
    @navigate("screen/#{first_screen}", trigger: true)

  show: (id) ->
    screen = @screens.get(id)
    @view = new VanderlandenDemo.Views.Screens.ShowView(model: screen)
    $("#screens").html(@view.render().el)
    window.screen = screen
