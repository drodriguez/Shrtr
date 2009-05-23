require 'rubygems'
require 'test/unit'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

require File.expand_path("#{File.dirname(__FILE__)}/../init")

Test::Unit::TestCase.send :include, Rack::Test::Methods
Test::Unit::TestCase.class_eval "def app; MyApp::Application.new; end"

