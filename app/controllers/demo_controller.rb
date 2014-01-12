class DemoController < ApplicationController

  def index
    @screens = Screen.demo
  end
end
