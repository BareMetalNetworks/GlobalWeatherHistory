require 'json'
require 'httparty'
require 'nokogiri'

foo = []
url = "https://water.weather.gov/ahps2/hydrograph_to_xml.php?gage=sfri1&output=tabular&time_zone=mst"
@document = Nokogiri::HTML(HTTParty.get(url).body)
@table = @document.search('table').last
@table.search('tr').each do |tr|
  cells = tr.search('th, td')
    cells.each {|cell|
      foo.push cell.text.strip
    }
end

p foo[4..5]
