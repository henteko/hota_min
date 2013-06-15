class Infomation < ActiveRecord::Base
  attr_accessible :birth_year, :latitude, :longitude

  def self.set(args)
    return false if !Infomation.check_set_args?(args)
    latitude = args[:latitude]
    longitude = args[:longitude]
    birth_year = args[:birth_year]
    user_id = args[:user_id]

    infomation = Infomation.search_from_to(600, :first) 

    infomation = Infomation.new if infomation.nil?
    infomation.latitude = latitude
    infomation.longitude = longitude
    infomation.birth_year = birth_year
    infomation.user_id = user_id

    infomation.save
  end

  def self.check_set_args?(args)
    latitude = args[:latitude] || ''
    longitude = args[:longitude] || ''
    birth_year = args[:birth_year] || ''
    user_id = args[:user_id] || ''

    return false if latitude.blank? || longitude.blank? || birth_year.blank? || user_id.blank?
    return true
  end

  def self.search_from_to(minuts, option)
    from = Time.now - minuts 
    to = from + minuts

    return Infomation.find(option, :conditions => {:updated_at => from...to})
  end

  def self.lookup(birth_year)
    generation = Infomation.get_generation(birth_year)

    g_infomations = []
    infomations = Infomation.search_from_to(600, :all) 
    infomations.each do |info|
      _generation = Infomation.get_generation(info.birth_year)
      if generation == _generation
        g_infomations.push(info)
      end
    end

    result = []
    g_infomations.each do |info|
      count = 0
      calculation = Infomation.calculation(info.latitude.to_f, info.longitude.to_f)
      max = calculation[:max]
      min = calculation[:min]
      g_infomations.each do |_info|
        if max[:latitude] <= _info.latitude.to_f && min[:latitude] >= _info.latitude.to_f
          if max[:longitude] <= _info.longitude.to_f && min[:longitude] >= _info.longitude.to_f
            count += 1
          end
        end
      end
      if 5 <= count
        result.push({
          :count => count,
          :infomation => info
        })
      end
    end

    result.sort! do |a, b|
      b.count <=> a.count
    end
    return result
  end

  def self.get_generation(birth_year)
    d = Date.today
    year = d.strftime("%Y")

    age = year.to_i - birth_year.to_i
    return (age / 10).truncate
  end

  def self.calculation(latitude, longitude)
    limit = 100

    latitude_second = 0.00027778
    latitude_second_distance = 30.8184

    pi = 3.1415926535897932384
    cir = 6356752 * Math.cos(latitude.to_i.truncate / 180 * pi) * (2 * pi)
    longitude_degrees = cir / 360
    longitude_second_distance = cir / (360 * 60 * 60)

    max_latitude = latitude + (limit / latitude_second_distance * latitude_second)
    max_longitude = longitude + (limit / longitude_second_distance * latitude_second)

    min_latitude = latitude - (limit / latitude_second_distance * latitude_second)
    min_longitude = longitude - (limit / longitude_second_distance * latitude_second)

    return {
      :max => {
        :latitude => max_latitude,
        :longitude => max_longitude
      },
      :min => {
        :latitude => min_latitude,
        :longitude => min_longitude
      }
    }
  end
end
