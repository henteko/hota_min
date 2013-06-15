class Infomation < ActiveRecord::Base
  attr_accessible :birth_year, :latitude, :longitude

  def self.set(args)
    return false if !Infomation.check_set_args?(args)
    latitude = args[:latitude]
    longitude = args[:longitude]
    birth_year = args[:birth_year]

    infomation = Infomation.new
    infomation.latitude = latitude
    infomation.longitude = longitude
    infomation.birth_year = birth_year

    infomation.save
  end

  def self.check_set_args?(args)
    latitude = args[:latitude] || ''
    longitude = args[:longitude] || ''
    birth_year = args[:birth_year] || ''

    return false if latitude.blank? || longitude.blank? || birth_year.blank?
    return true
  end

  def self.lookup(birth_year)

  end
end
