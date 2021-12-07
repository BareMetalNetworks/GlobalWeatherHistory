## Retrieve Weather Data
require 'httparty'
require 'json'

def weathergov_request(url)
  response = HTTParty.get(url)
  response.body if response.code == 200
  JSON.parse(response.body)
end

#p get_forecast('BOI/182,24')
# maybe this can be retrieved using station_id instead of a gridpoint
def get_forecast(station)
  weathergov_request('https://api.weather.gov/gridpoints/' +
     station + '/forecast')
end

#p get_weather_alerts("ID")
def get_weather_alerts(state)
 weathergov_request('https://api.weather.gov/alerts/active?area=' + state)
end

#p get_current_observations("KTWF")
def get_current_observations(station)
 weathergov_request("https://api.weather.gov/stations/#{station}/observations")
end


__END__
# STATION
# stationId KTWF
# FORECAST

# https://api.weather.gov/gridpoints/BOI/182,24/forecast


# p get_weather_alerts('ID')['features'][0]['properties']['description']
# properties for each alert in array
# nt", "effective", "onset", "expires", "ends", "status", "messageType", "category", "severity", "certainty", "urgency", "event", "sender", "senderName", "headline", "description", "instruction", "response", "parameters"]


#https://forecast.weather.gov/stations.php
https://forecast.weather.gov/data/obhistory/KTWF.html
