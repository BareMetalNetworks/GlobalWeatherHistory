## Retrieve Weather Data

require 'httparty'

alerts = 'https://api.weather.gov/alerts/active?area=ID'


def make_request(url)


response = HTTParty.get(url)
puts response.body if response.code == 200

end

p make_request(alerts)
