class TrainSearcher

  attr_reader :departure_times

  def initialize(station)
    @station = station
    @departure_times = []
    load_schedule
    search_schedule_for_station
  end

  def load_schedule
    @file = File.readlines("data/stop_times.txt")
    @file.shift
    @file
  end

  def search_schedule_for_station
    @file.each do |arrival|
      if arrival.include?(@station)
        @departure_times << arrival.split(',  ')[2] 
      end 
    end
    clean_up_station_times
  end

  def clean_up_station_times
    @departure_times = @departure_times.uniq
    @departure_times.map! do |time|
      time.gsub!(/\:/,'')
      time[0..3].to_i
    end
    @departure_times.sort!
    @departure_times
  end

end