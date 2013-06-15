class Api::InfomationsController < ApplicationController
  def create
    result = Infomation.set(params)
    render :json => {'result' => result}
  end

  def search 
    birth_year = params[:birth_year] || '1991'
    result = Infomation.lookup(birth_year)
    render :json => {'result' => result}
  end

  def hotspot
    hotspot_num = 5
    birth_year = params[:birth_year] || '1991'
    result = Infomation.lookup(birth_year)

    count = 0
    json = []
    result.each do |info|
      break if count > hotspot_num 
      json.push(info)
      count += 1
    end

    render :json => {'result' => json}
  end
end
