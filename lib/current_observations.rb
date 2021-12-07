class CurrentObservations
  def initialize(station)
    @station = station
    @response = []
  end

  def request(url)
    resp = HTTParty.get(url)
    resp.body if response.code == 200
    @response = JSON.parse(resp.body)
  end

  



end
