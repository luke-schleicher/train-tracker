require 'pry'

class StationSearcher

  attr_reader :closest_station, :closest_station_coords

  def initialize(user_coords)
    @user_coords = user_coords
    @stations = []
    load_stations
    produce_station_array
    find_closest_station
  end

  def load_stations
    @file = File.readlines("data/stops.txt")
    @file.shift
    @file
  end

  def produce_station_array
    @file.each do |station|
      station_info = station.split(', ')
      @stations << station_info.select do |info|
        station_info.index(info) == 0 || station_info.index(info) == 3 || station_info.index(info) == 4
      end
    end
  end

  def find_closest_station
    shortest_distance = 100
    @stations.each do |station|
      distance_dif = 0
      station.each_index do |index|
        next if index == 0
        distance_dif += (station[index].to_f - @user_coords[index - 1].to_f).abs
      end
      if shortest_distance?(distance_dif, shortest_distance)
        @closest_station = station[0]
        @closest_station_coords = [station[1], station[2]] 
        shortest_distance = distance_dif
      end
    end
  end

  def shortest_distance?(distance_dif, shortest_distance)
    true if distance_dif < shortest_distance
  end

end

