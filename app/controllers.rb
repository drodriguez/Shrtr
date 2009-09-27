require 'ruby-debug'
module Shrtr
  
  module Controllers

    get '/' do
      @mode = Sinatra::Application.environment
      @data = Time.now
      erb :index
    end
    
  end
  
end