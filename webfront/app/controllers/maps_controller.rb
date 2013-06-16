class MapsController < ApplicationController
  def show
    @results = Infomation.all_generation
  end
end
