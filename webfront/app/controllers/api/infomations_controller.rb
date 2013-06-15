require 'rexml/document'
require 'open-uri'

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
    url = 'http://www.geocoding.jp/api/?v=1.1&q='
    hotspot_num = 5
    birth_year = params[:birth_year] || '1991'
    result = Infomation.lookup(birth_year)

    count = 0
    json = []
    result.each do |info|
      break if count > hotspot_num 
      latitude = info[:infomation].latitude
      longitude = info[:infomation].longitude
      url += latitude + ',' + longitude
      doc = REXML::Document.new(open(url))
      adress = doc.elements['result/google_maps'].text
      json.push({
        :adress => adress,
        :result => result
      })
      count += 1
    end

    render :json => {'hotspot' => json}
  end
end
