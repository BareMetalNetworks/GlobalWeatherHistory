require 'httparty'
require 'json'

class CurrentObservations
  def initialize(station_id, station, state)
    @station_id = station_id # reduce to one id
    @station = station
    @state = state
    @response = []
  end

  def request(url)
    resp = HTTParty.get(url)
    resp.body if resp.code == 200
    @response = JSON.parse(resp.body)
  end

  def get_current
    request("https://api.weather.gov/stations/#{@station_id}/observations")
  end

  def get_forecast
    request("https://api.weather.gov/gridpoints/#{@station}/forecast")
  end
  def get_alerts
    request("https://api.weather.gov/alerts/active?area=#{@state}")
  end
end


#c = CurrentObservations.new("KTWF", 'BOI/182,24', "ID")
#p c.get_current
#p c.get_forecast
