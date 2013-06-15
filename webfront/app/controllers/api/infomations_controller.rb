class Api::InfomationsController < ApplicationController
  def create
    result = Infomation.set(params)
    render :json => {'result' => result}
  end

  def show
    birth_year = params[:id] || '1991'
    result = Infomation.lookup(birth_year)
    render :json => {'result' => result}
  end
end
