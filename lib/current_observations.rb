require 'httparty'
require 'json'
require 'active_record'
require 'nokogiri'


class Hydrological

  def request(url)
    @response = HTTParty.get(url).body
  end

end


h = Hydrological.new
p h.request("https://water.weather.gov/ahps2/hydrograph_to_xml.php?gage=sfri1&output=tabular&time_zone=mst")


ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: './data/database'
)

class Station < ActiveRecord::Base
  has_many :observations
  has_many :alerts
  has_many :forecasts

  def fetch_all_current_data
    get_alerts()
    get_forecast()
    get_current_observations()
  end

  def request(url)
    @response = JSON.parse(HTTParty.get(url).body)
  end

  def get_alerts
    @alerts =
      request("https://api.weather.gov/alerts/active?area=#{self.state}")

      @alerts["features"].each do |alert|
        self.alerts << Alert.create!(
          headline: alert["properties"]["headline"] || "",
          description: alert["properties"]["description"] || "",
          effective: alert["properties"]["effective"] || "",
          expires: alert["properties"]["expires"] || "",
          category: alert["properties"]["category"] || "",
          severity: alert["properties"]["severity"] || "",
          certainty: alert["properties"]["certainty"] || "",
          urgency: alert["properties"]["urgency"] || "",
          event: alert["properties"]["event"] || "",
          instruction: alert["properties"]["instruction"] || "",
          affected_zones: alert["properties"]["affectedZones"] || "",
          area_desc: alert["properties"]["areaDesc"] || "",
          )
          self.save!
   end
end

  def get_forecast
    @forecast =
      request("https://api.weather.gov/gridpoints/#{self.station_grid}/forecast")

      @forecast["properties"]["periods"].each do |cast|
        self.forecasts << Forecast.create!(
          start_time: cast["startTime"],
          end_time: cast["endTime"],
          temperature: cast["temperature"],
          temperature_trend: cast["temperatureTrend"],
          is_daytime: cast["isDaytime"],
          wind_speed: cast["windSpeed"],
          wind_direction: cast["windDirection"],
          short_forecast: cast["shortForecast"],
          detailed_forecast: cast["detailedForecast"],
         )
         self.save!
      end

  end

  def get_current_observations
    @raw_current =
      request("https://api.weather.gov/stations/#{self.station_id}/observations")


      @raw_current["features"].each do |c|
        capture = create_capture_timestamp(c["properties"]["timestamp"])
        self.observations << Observation.create!(
         epoch: capture,
         raw_date: c["properties"]["timestamp"],
         temperature: c["properties"]["temperature"]["value"] || 0.0,
         wind_direction: c["properties"]["windDirection"]["value"] || 0.0,
         wind_gust: c["properties"]["windGust"]["value"] || 0.0,
         station_pressure: c["properties"]["barometricPressure"]["value"] || 0.0,
         sea_level_pressure: c["properties"]["seaLevelPressure"]["value"] || 0.0,
         visibility: c["properties"]["visibility"]["value"] || 0.0,
         dew_point: c["properties"]["dewPoint"] || 0.0,
         max_temp: c["properties"]["maxTemperatureLast24Hours"]["value"] || 0.0,
         min_temp:  c["properties"]["minTemperatureLast24Hours"]["value"] || 0.0,
         precipitation:  c["properties"]["preciptationLastHour"] || 0.0,
         humidity: c["properties"]["relativeHumidity"]["value"] || 0.0,
         wind_chill: c["properties"]["windChill"]["value"] || 0.0,
         cloud_layers: c["properties"]["cloudLayers"] || 0.0,
         wind_speed: c["properties"]["windSpeed"]["value"] || 0.0,
         heat_index: c["properties"]["heatIndex"]["value"] || 0.0,
     )
      self.save!
      end
   end

     def create_capture_timestamp(raw_timestamp) # 2021-12-09T03:53:00+00:00
       b = DateTime.parse(raw_timestamp)
       Time.new(b.year, b.month, b.day, b.hour, b.minute).to_i
     end
end

class Forecast < ActiveRecord::Base
  belongs_to :station
end

class Alert < ActiveRecord::Base
  belongs_to :station
end

class Observation < ActiveRecord::Base
  belongs_to :station
  # def get_cloud_layers(l)
  #   return "UNK" if l[0].nil?
  #   l[0]["amount"]
  # end
  #

  #
  #   def convert_c_to_f(temp)
  #     (temp.to_f * 9.0 / 5.0 + 32).truncate(2)
  #   end

end


__END__

--- hydrological data ---

salmon dam
https://water.weather.gov/ahps2/hydrograph_to_xml.php?gage=sfri1&output=tabular&time_zone=mst
https://water.weather.gov/ahps2/hydrograph.php?wfo=boi&gage=sfri1
(historical)
https://waterdata.usgs.gov/id/nwis/uv?site_no=13106500
https://waterdata.usgs.gov/monitoring-location/13106500/#parameterCode=00065&period=P7D

salmon river (upstream)
https://water.weather.gov/ahps2/hydrograph_to_xml.php?gage=sfln2&output=tabular&time_zone=pst
https://water.weather.gov/ahps2/hydrograph.php?wfo=lkn&gage=sfln2&prob_type=stage&source=hydrograph

salmon river (downstream)
https://water.weather.gov/ahps2/hydrograph.php?wfo=boi&gage=hagi1&prob_type=stage&source=hydrograph
https://water.weather.gov/ahps2/hydrograph_to_xml.php?gage=hagi1&output=tabular&time_zone=mst

us wide water resources
https://waterdata.usgs.gov/nwis/rt

api request building tool
https://waterservices.usgs.gov/rest/IV-Test-Tool.html

["@id", "@type", "elevation", "station", "timestamp",
  "rawMessage", "textDescription", "icon", "presentWeather",
  "temperature", "dewpoint", "windDirection", "windSpeed",
   "windGust", "barometricPressure", "seaLevelPressure",
   "visibility", "maxTemperatureLast24Hours", "minTemperatureLast24Hours",
    "precipitationLastHour", "precipitationLast3Hours",
     "precipitationLast6Hours", "relativeHumidity", "windChill",
      "heatIndex", "cloudLayers"]
