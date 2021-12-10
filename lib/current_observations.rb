require 'httparty'
require 'json'

class Observation
  attr_reader :obs, :timestamp, :temperature, :presentWeather, :dewPoint,
    :windDirection, :windSpeed, :windGust, :pressure, :seaLevelPressure,
    :visibility, :maxTemp, :minTemp, :precipLastHour, :precipLast3Hours,
    :precipLast6Hours, :humidity, :windChill, :heatIndex, :cloudLayers
  def initialize(p)
    @obs = p
    @timestamp = p["timestamp"]
    @temperature = p["temperature"]["value"]
    @windDirection = p["windDirection"]["value"]
    @windSpeed = p["windSpeed"]["value"]
    @windGust = p["windGust"]["value"]
    @pressure = p["barometricPressure"]["value"]
    @seaLevelPressure = p["seaLevelPressure"]["value"]
    @visibility = p["visibility"]["value"]


    @presentWeather = p["presentWeather"]
    @dewPoint = p["dewPoint"]


    @maxTemp = p["maxTemperatureLast24Hours"]["value"]
    @minTemp = p["minTemperatureLast24Hours"]
    @precipLastHour = p["preciptationLastHour"]
    @precipLast3Hours = p["preciptationLast3Hours"]
    @precipLast6Hours = p["preciptationLast6Hours"]
    @humidity = p["realtiveHumidity"]
    @windChill = p["windChill"]
    @heatIndex = p["heatIndex"]
    @cloudLayers = p["cloudLayers"]
  end
end

class CurrentObservations
  attr_reader :current, :forecast, :alerts
  def initialize(station_id, station, state)
    @station_id = station_id # reduce to one id
    @station = station
    @state = state
    @response = []
    @raw_current = []
    @current = [] #AoH
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
      @current.push(Observation.new(c["properties"]))
    end
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
