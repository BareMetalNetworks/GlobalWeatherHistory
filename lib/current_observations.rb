require 'httparty'
require 'json'

class Observation
  def initialize(timestamp)
    @timestamp = timestamp
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
    @raw_current = request("https://api.weather.gov/stations/#{@station_id}/observations")

    @raw_current["features"].each do |c|
      p c["properties"].keys
      @current.push(Observation.new(c["properties"]["timestamp"]))
      # c["properties"].each do |p|
      #     p p[1..10]
      # end
    end
  end

  def get_forecast
    @forecast = request("https://api.weather.gov/gridpoints/#{@station}/forecast")
  end
  def get_alerts
    @alerts = request("https://api.weather.gov/alerts/active?area=#{@state}")
  end
end


c = CurrentObservations.new("KTWF", 'BOI/182,24', "ID")
 c.get_current
 p c.current
#p c.get_forecast