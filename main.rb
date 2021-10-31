require 'csv'
require 'sqlite3'
require 'active_record'
require 'pry'

# Connect to an in-memory sqlite3 database
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

ActiveRecord::Schema.define do
    create_table :joslin_fields, force: true do |t|
      t.date :capture_date
      t.float :temp
      t.float :dew_point
      t.float :station_pressure
      t.float :sea_level_pressure
      t.float :visibility
      t.float :wind_speed
      t.float :wind_max
     # t.float :wind_gust
      t.float :temp_max
      t.float :temp_min
      t.float :precipitation
      t.float :snow_depth

    end
  end

  class JoslinField < ActiveRecord::Base; end

data = []

CSV.foreach("72586699999.csv") do |row|
row.map{ |x| x.gsub(/[^0-9a-z ]/i, '')}
data.push row
entry = JoslinField.create!(capture_date: row[1], temp: row[6], dew_point: row[8],
    visibility: row[14], wind_speed: row[16], wind_max: row[18], #wind_gust: row[19], 
    temp_max: row[20], temp_min: row[22], precipitation: row[24], snow_depth: row[26],
    station_pressure: row[12], sea_level_pressure: row[10])

end

p JoslinField.find_by(capture_date: "1995-7-22")


__END__

