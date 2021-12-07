require 'httparty'
require 'json'

class CurrentObservations
  def initialize(station)
    @station = station
    @response = []
  end

  def request(url)
    resp = HTTParty.get(url)
    resp.body if resp.code == 200
    @response = JSON.parse(resp.body)
  end

  def get_current
    request("https://api.weather.gov/stations/#{@station}/observations")
  end


end

c = CurrentObservations.new("KTWF")
p c.get_current
