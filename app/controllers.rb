require 'ruby-debug'
require 'digest/sha1'

module Shrtr
  
  module Controllers
    
    set :sessions, true
    
    before do
      Shrtr::URL.connect!(@config['db'])
=begin
      if params['username']
        @valid_user = params['username'] == @config['username'] &&
          Digest::SHA1.hexdigest(params['password']) == @config['password']
      elsif params['api']
        @valid_user = params['api'] == @config['api_key']
      end
      
      if params['logout']
        session['username'] = session['password'] = ''
        redirect '/-shrtr-/'
      end
      
      if not @valid_user
        halt haml(:login)
      elsif not params['api']
        session['username'] = @config['username']
        session['password'] = @config['password']
      end
=end
    end

    get '/-shrtr-/' do
      haml :add
    end
    
    post '/-shrtr-/' do
      if params['url'] && !params['url'].empty?
        @url = Shrtr::URL.find_by_url(params['url'])
        
        if params['api']
          @url.shrtr_id
        else
          haml :done
        end
      end
    end
    
    get '/-shrtr-/login' do
      haml :login
    end
    
    post '/-shrtr-/login' do
      @valid_user = params['username'] == @config['username'] &&
        Digest::SHA1.hexdigest(params['password']) == @config['password']
    end
    
    post '/-shrtr-/logout' do
      
    end
    
    get '/:key' do
      
    end
    
    private
    
    def cookie_value
      @cookie_value ||= "#{@config['username']}#{@config['password']}#{@config['cookie_salt']}"
    end
    
  end
  
end