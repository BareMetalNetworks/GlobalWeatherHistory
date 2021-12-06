require_relative "retrieve.rb"

def parse_current_observations(station)
  get_current_observations(station)
end

b = parse_current_observations("KTWF")
p b["features"][0]["properties"]["temperature"]
