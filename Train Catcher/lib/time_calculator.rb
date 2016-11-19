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