require 'sinatra'
require 'erb'
require 'sinatra/reloader' if development?
require File.expand_path('./helpers/train_lookup', File.dirname(__FILE__))

helpers TrainLookup

get '/' do

  train_searcher = TrainLookup::TrainSearcher.new('COLLEGEAVE')
  station_departure_times = train_searcher.departure_times

  time_calculator = TrainLookup::TimeCalculator.new(station_departure_times)

  minutes_until_train_arrives = time_calculator.time_to_train

  conductor = TrainLookup::Conductor.new

  train_verdict = conductor.make_decision(minutes_until_train_arrives)

  erb :index, locals: { train_verdict: train_verdict,
                        minutes_until_train_arrives: minutes_until_train_arrives
                      }
end