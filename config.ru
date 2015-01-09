require 'rubygems'
require 'sinatra/base'

Dir.glob('./{models,controllers,helpers}/*.rb').each { |file| require file }

run ApplicationController.new
