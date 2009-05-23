require 'ruby-debug'
module MyApp
  
  module Controllers

    get '/' do
      @mode = Sinatra::Application.environment
      @data = Time.now
      erb :index
    end
    
  end
  
end