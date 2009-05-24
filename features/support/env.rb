require 'rubygems'
require 'rack/test'

ENV['RACK_ENV'] = 'test'
 
require File.expand_path("#{File.dirname(__FILE__)}/../../init") 
 
World do
  def app
    @app = MyApp::Application.new
  end
  include Rack::Test::Methods
  # include webrat and other stuff here
end