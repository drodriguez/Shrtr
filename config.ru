# ENV['RACK_ENV'] = 'deployment'

require 'init'

run MyApp::Application.new