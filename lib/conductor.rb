require 'json'

class Conductor

  MAPS_ENDPOINT = 'https://maps.googleapis.com/maps/api/directions/json?'

  def initialize(minutes_until_train_arrives, user_coords, station_searcher)
    @minutes_until_train_arrives = minutes_until_train_arrives
    origin = 'origin=' + user_coords.join(',') + '&'
    destination = 'destination=' + station_searcher.closest_station_coords.join(',') + '&'
    endpoint = MAPS_ENDPOINT + origin + destination + 'key=' + ENV['METRA_GOOGLE_MAPS']
    maps_string = `curl #{endpoint}`
    @json = JSON.parse(maps_string)
  end

  def minutes_to_station
    4
  end

  def make_decision
    true if @minutes_until_train_arrives > minutes_to_station
  end

end