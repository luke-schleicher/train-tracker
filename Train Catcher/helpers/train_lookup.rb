require 'pry'

module TrainLookup
  class TrainSearcher

    attr_reader :departure_times

    def initialize(station)
      @station = station
      @departure_times = []
      load_schedule
      search_schedule
    end

    def load_schedule
      @file = File.readlines("data/stop_times.txt")
      @file.shift
      @file
    end

    def search_schedule
      @file.each do |line|
        if line.include?(@station)
          @departure_times << line.split(',  ')[2] 
        end
      end
      @departure_times = @departure_times.uniq
      @departure_times.map! do |time|
        time.gsub!(/\:/,'')
        time[0..3].to_i
      end
      @departure_times.sort!
      @departure_times
    end

  end

  class TimeCalculator

    def initialize(station_departure_times)
      @station_departure_times = station_departure_times
    end

    def now
      Time.now.strftime('%H%M').to_i
    end

    def next_departure_time
      @station_departure_times.find do |time|
        time > now
      end
    end

    def time_to_train
      next_departure_time - now
    end

  end

  class Conductor

    def minutes_to_station
      4
    end

    def make_decision(minutes_until_train_arrives)
      true if minutes_until_train_arrives > minutes_to_station
    end

  end

end