require 'csv'
require 'sqlite3'
require 'active_record'
require 'pry'
require_relative 'libdb'

# Connect to an in-memory sqlite3 database
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: './database'
)

p History.all.count

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
