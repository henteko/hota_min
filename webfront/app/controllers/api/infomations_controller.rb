class Api::InfomationsController < ApplicationController
  def create
    result = Infomation.set(params)
    render :json => {'result' => result}
  end

  def index
  end
end
