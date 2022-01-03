require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: './data/database'
)
ActiveRecord::Schema.define do

    create_table :hydrologicals, force: true do |t|
      t.string :name
      t.string :location
      t.string :classification
      t.float :capacity
      t.float :flood_stage
      t.string :url
    end

    create_table :water_observations, force: true do |t|
      t.timestamps
      t.float :stage
      t.float :flow
      t.belongs_to :hydroloical, index: true
    end


    create_table :stations, force: true do |t|
      t.string :location
      t.float :lat
      t.float :long
      t.float :elevation
      t.string :station_grid
      t.string :station_id
      t.string :state
      t.string :name
  end
    # change to weather obs
    create_table :observations, force: true do |t|
      t.integer :epoch
      t.date :capture
      t.string :raw_date
      t.float :dew_point
      t.float :temperature
      t.float :station_pressure
      t.float :sea_level_pressure
      t.float :visibility
      t.float :wind_speed
      t.float :wind_gust
      t.float :max_temp
      t.float :min_temp
      t.float :precipitation
      t.float :heat_index
      t.string :cloud_layers
      t.float :humidity
      t.float :wind_chill
      t.float :wind_direction
      t.timestamps
      t.belongs_to :station, index: true
    end

  create_table :alerts, force: true do |t|
      t.belongs_to :station, index: true
      t.string :headline
      t.text :description
      t.string :effective
      t.string :expires
      t.string :category
      t.string :severity
      t.string :certainty
      t.string :urgency
      t.string :event
      t.string :instruction
      t.string :affected_zones
      t.string :area_desc
    end

    create_table :forecasts, force: true do |t|
      t.belongs_to :station, index: true
      t.datetime :start_time
      t.datetime :end_time
      t.string :is_daytime
      t.float :temperature
      t.string :temperature_unit
      t.string :temperature_trend
      t.float :wind_speed
      t.float :wind_direction
      t.text :short_forecast
      t.text :detailed_forecast
    end
end
