require 'sqlite3'
require 'active_record'

# Connect to an in-memory sqlite3 database
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: './database'
)

ActiveRecord::Schema.define do
    create_table :histories, force: true do |t|
      t.integer :station
      t.string :location
      t.date :capture_date
      t.float :lat
      t.float :long
      t.float :elevation
      t.float :temp_avg
      t.float :dew_point
      t.float :station_pressure
      t.float :sea_level_pressure
      t.float :visibility
      t.float :wind_speed
      t.float :wind_max
      t.float :wind_gust
      t.float :temp_max
      t.float :temp_min
      t.float :precipitation
      t.float :snow_depth

    end
  end

  class History < ActiveRecord::Base; end
