require 'sinatra'
require 'erb'
require 'sinatra/reloader' if development?

require File.expand_path('./lib/train_searcher', File.dirname(__FILE__))
require File.expand_path('./lib/user', File.dirname(__FILE__))
require File.expand_path('./lib/station_searcher', File.dirname(__FILE__))
require File.expand_path('./lib/conductor', File.dirname(__FILE__))
require File.expand_path('./lib/time_calculator', File.dirname(__FILE__))

get '/' do

  user_location = User.new
  user_coords = user_location.coords

  station_searcher = StationSearcher.new(user_coords)
  closest_station = station_searcher.closest_station

  train_searcher = TrainSearcher.new(closest_station)
  station_departure_times = train_searcher.departure_times

  time_calculator = TimeCalculator.new(station_departure_times)
  minutes_until_train_arrives = time_calculator.time_to_train

  conductor = Conductor.new(minutes_until_train_arrives, user_coords, station_searcher)
  train_verdict = conductor.make_decision

  erb :index, locals: { closest_station: closest_station,
                        train_verdict: train_verdict,
                        minutes_until_train_arrives: minutes_until_train_arrives
                      }
end