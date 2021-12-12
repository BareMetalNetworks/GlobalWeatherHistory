require 'httparty'
require 'json'
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: './database'
)


ActiveRecord::Schema.define do
  create_table :stations, force: true do |t|
    t.string :location
    t.float :lat
    t.float :long
    t.float :elevation
    t.string :station_name
    t.string :station_id
    t.string :state
    t.string :name
end

    create_table :observations, force: true do |t|
      t.integer :epoch
      #t.string :location
      t.date :capture
      t.string :raw_date
      #t.float :lat
      #t.float :long
      #t.float :elevation
      #t.float :temp_avg
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


  end

class Station < ActiveRecord::Base
  has_many :observations

  def request(url)
    @response = JSON.parse(HTTParty.get(url).body)
  end

  def get_current
    @raw_current =
      request("https://api.weather.gov/stations/#{@station_id}/observations")

    @raw_current["features"].each do |c|
      @current.push(c["properties"])
    end
    #@current
  end
end

class Observation < ActiveRecord::Base
  belongs_to :station

  #
  # def get_cloud_layers(l)
  #   return "UNK" if l[0].nil?
  #   l[0]["amount"]
  # end
  #
  #   def create_primary_key(raw_timestamp) # 2021-12-09T03:53:00+00:00
  #     b = DateTime.parse(raw_timestamp)
  #     Time.new(b.year, b.month, b.day, b.hour, b.minute).to_i
  #   end
  #
  #   def convert_c_to_f(temp)
  #     (temp.to_f * 9.0 / 5.0 + 32).truncate(2)
  #   end

end

class CurrentObservations
  attr_reader :current, :forecast, :alerts
  def initialize(station_id, station, state)
    @station_id = station_id # reduce to one id
    @station = station
    @state = state
    @response = []
    @raw_current = []
    @current =[]
    @forecast = []
    @alerts = []
  end

  def request(url)
    @response = JSON.parse(HTTParty.get(url).body)
  end

  def get_current
    @raw_current =
      request("https://api.weather.gov/stations/#{@station_id}/observations")

    @raw_current["features"].each do |c|
      @current.push(c["properties"])
    end
    #@current
  end

  def get_forecast
    @forecast =
      request("https://api.weather.gov/gridpoints/#{@station}/forecast")
  end
  def get_alerts
    @alerts =
      request("https://api.weather.gov/alerts/active?area=#{@state}")
  end
end

s = Station.create(station_name: "KTWF", station_id: 'BOI/182,24', state: "ID",
        name: "Joslin Field")
p s



 c = CurrentObservations.new("KTWF", 'BOI/182,24', "ID")
  c.get_current

 c.current.each do |p|
    o = Observation.create!(raw_date: p["timestamp"],
      temperature: p["temperature"]["value"],
      dew_point: p["dewPoint"],
      station_pressure: p["barometricPressure"]["value"],
      sea_level_pressure: p["seaLevelPressure"]["value"],
      visibility: p["visibility"]["value"],
      wind_speed: p["windSpeed"]["value"],
      wind_gust: p["windGust"]["value"],
      max_temp: p["maxTemperatureLast24Hours"]["value"],
      min_temp:  p["minTemperatureLast24Hours"]["value"],
      precipitation: p["preciptationLastHour"],
      heat_index: p["heatIndex"]["value"],
      cloud_layers: p["cloudLayers"],
      humidity: p["realtiveHumidity"],
      wind_chill: p["windChill"]["value"],
      wind_direction: p["windDirection"]["value"]
 )
    s.observations << o
end

p s.observations.count

# s.observations << o
# p s.observations

# c = CurrentObservations.new("KTWF", 'BOI/182,24', "ID")
#  c.get_current
# p c.current[1].timestamp
#p c.get_forecast

__END__
["@id", "@type", "elevation", "station", "timestamp",
  "rawMessage", "textDescription", "icon", "presentWeather",
  "temperature", "dewpoint", "windDirection", "windSpeed",
   "windGust", "barometricPressure", "seaLevelPressure",
   "visibility", "maxTemperatureLast24Hours", "minTemperatureLast24Hours",
    "precipitationLastHour", "precipitationLast3Hours",
     "precipitationLast6Hours", "relativeHumidity", "windChill",
      "heatIndex", "cloudLayers"]
