## Retrieve Weather Data

require 'httparty'


def get_weather_alerts(state)
 weathergov_request('https://api.weather.gov/alerts/active?area=' + state)
end


def weathergov_request(url)
response = HTTParty.get(url)
response.parsed_response if response.code == 200
end


## EXAMPLES ##
#p get_weather_alerts('ID')
