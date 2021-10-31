require 'csv'
require 'sqlite3'
require 'active_record'
require 'pry'
require_relative 'libdb'

files = Dir.entries("../global_data/archive")[2..-1]
data = []
#files = files[0..10]

files.each do |file| 
CSV.foreach("../global_data/archive/#{file}") do |row|
next if row.nil?
row.map{ |x| next if x.nil?; x.gsub(/[^0-9a-z ]/i, '')}

data.push row
entry = History.create!(

station: row[0], lat: row[2], long: row[3], elevation: row[4], location: row[5],
capture_date: row[1], temp_avg: row[6], dew_point: row[8],
    visibility: row[14], wind_speed: row[16], wind_max: row[18], wind_gust: row[19], 
    temp_max: row[20], temp_min: row[22], precipitation: row[24], snow_depth: row[26],
    station_pressure: row[12], sea_level_pressure: row[10])

end
sleep 60
rescue CSV::MalformedCSVError
  p file
  p row
end

p History.find_by(capture_date: "1977-7-22")


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