# ENV['RACK_ENV'] = 'deployment'

require 'init'

run Shrtr::Application.new