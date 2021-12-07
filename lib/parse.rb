require_relative "retrieve.rb"

def parse_current_observations(station)
  get_current_observations(station)
end

b = parse_current_observations("KTWF")

d = b["features"]
p d[166]["properties"]["timestamp"]

data = d[166]["properties"]
p data

__END__
["@id", "@type", "elevation", "station", "timestamp",
  "rawMessage", "textDescription", "icon", "presentWeather",
  "temperature", "dewpoint", "windDirection", "windSpeed",
   "windGust", "barometricPressure", "seaLevelPressure",
   "visibility", "maxTemperatureLast24Hours", "minTemperatureLast24Hours",
    "precipitationLastHour", "precipitationLast3Hours",
     "precipitationLast6Hours", "relativeHumidity", "windChill",
      "heatIndex", "cloudLayers"]
