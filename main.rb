require 'json'
require_relative 'lib/current_observations'
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: './lib/data/database'
)

s = Station.create!(station_id: "KTWF", station_grid: 'BOI/182,24', state: "ID",
        name: "Joslin Field")

# s.fetch_all_current_data
# p s.observations.count
# p s.observations.last
# p s.forecasts.all.map {|x|  x.start_time.to_s + x.detailed_forecast.to_s}
# s.save!

# h = Hydrological.create!(name: "Salmon Dam",
#   url: "https://water.weather.gov/ahps2/hydrograph_to_xml.php?gage=sfri1&output=tabular&time_zone=mst")
#  data = h.get_water_data[4..6]
#
# h.insert(data)
# p h.waterlevels.all

# c.current.each_with_index do |x,i|
#   p "Index: #{i} Timestamp: #{x.timestamp} Primary: #{x.key} Temp: #{x.temperature}"
# end
__END__
:obs, :timestamp, :temperature, :presentWeather, :dewPoint,
  :windDirection, :windSpeed, :windGust, :pressure, :seaLevelPressure,
  :visibility, :maxTemp, :minTemp, :precipLastHour, :precipLast3Hours,
  :precipLast6Hours, :humidity, :windChill, :heatIndex, :cloudLayers, :key





















__END__


# CSV file meta
#_____________________________
# Index | Heading | DB_field_name
#-----------------------------
# 0 "STATION" station
# 1 "DATE" capture_date
# 2 "LATITUDE" lat
# 3 "LONGITUDE" long
# 4 "ELEVATION" elevation
# 5 "NAME" location
# 6 "TEMP" temp_avg
# 7 "TEMP_ATTRIBUTES"
# 8 "DEWP" dewpoint
# 9 "DEWP_ATTRIBUTES"
# 10 "SLP" sea_level_pressure
# 11 "SLP_ATTRIBUTES"
# 12 "STP" station_pressure
# 13 "STP_ATTRIBUTES"
# 14 "VISIB" Visibility
# 15 "VISIB_ATTRIBUTES"
# 16 "WDSP" wind_speed
# 17 "WDSP_ATTRIBUTES"
# 18 "MXSPD" wind_max
# 19 "GUST" wind_gust
# 20 "MAX" temp_max
# 21 "MAX_ATTRIBUTES"
# 22 "MIN" temp_min
# 23 "MIN_ATTRIBUTES"
# 24 "PRCP" precipitation
# 25 "PRCP_ATTRIBUTES"
# 26 "SNDP" snow_depth
# 27 "FRSHTT"
