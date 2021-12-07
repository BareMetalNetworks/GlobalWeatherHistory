require_relative "current_observations"

c = CurrentObservations.new("KTWF", 'BOI/182,24', "ID")
 c.get_current


__END__

d = b["features"]
p d[166]["properties"]["timestamp"]

data = d[166]["properties"]["presentWeather"]
p data

["@id", "@type", "elevation", "station", "timestamp",
  "rawMessage", "textDescription", "icon", "presentWeather",
  "temperature", "dewpoint", "windDirection", "windSpeed",
   "windGust", "barometricPressure", "seaLevelPressure",
   "visibility", "maxTemperatureLast24Hours", "minTemperatureLast24Hours",
    "precipitationLastHour", "precipitationLast3Hours",
     "precipitationLast6Hours", "relativeHumidity", "windChill",
      "heatIndex", "cloudLayers"]
