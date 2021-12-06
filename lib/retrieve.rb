## Retrieve Weather Data

require 'httparty'
require 'json'

def get_forecast(station)
  weathergov_request('https://api.weather.gov/gridpoints/' +
     station + '/forecast')
end

def get_weather_alerts(state)
 weathergov_request('https://api.weather.gov/alerts/active?area=' + state)
end


def weathergov_request(url)
  response = HTTParty.get(url)
  response.body if response.code == 200
  JSON.parse(response.body)
end

#p get_forecast('BOI/182,24')
station_id = "KTWF"
p HTTParty.get(URI.parse("http://www.weather.gov/xml/current_obs/#{station_id}"))


__END__
# STATION
# stationId TWF
# FORECAST

# https://api.weather.gov/gridpoints/BOI/182,24/forecast


# p get_weather_alerts('ID')['features'][0]['properties']['description']
# properties for each alert in array
# nt", "effective", "onset", "expires", "ends", "status", "messageType", "category", "severity", "certainty", "urgency", "event", "sender", "senderName", "headline", "description", "instruction", "response", "parameters"]


#https://forecast.weather.gov/stations.php
https://forecast.weather.gov/data/obhistory/KTWF.html
