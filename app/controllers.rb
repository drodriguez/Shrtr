require 'ruby-debug'
require 'digest/sha1'
require 'active_support'

module Shrtr
  
  module Controllers
    
    set :sessions, true
        
    before do
      if (/^\/-shrtr-\// =~ request.path) != nil
        if (/^\/-shrtr-\/login/ =~ request.path) == nil
          authenticate
        end
      end
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
      else
        haml :add
      end
    end
    
    get '/-shrtr-/login' do
      haml :login
    end
    
    post '/-shrtr-/login' do
      @user = Shrtr::User.authenticate(params['username'],
        params['password'])
      
      if @user.nil?
        @flash = 'Bad username or password!'
        status 401 # unauthorized
        haml :login
      else
        sign_in(@user)
        redirect '/-shrtr-/'
      end
    end
    
    get '/-shrtr-/logout' do
      haml :logout
    end
    
    post '/-shrtr-/logout' do
      sign_out
      redirect '/-shrtr-/login'
    end
    
    get '/:id' do
      unless params['id'].empty?
        url = Shrtr::URL.find_by_shrtr_id(params['id'])
        redirect url.url if url
      end
      redirect '/-shrtr-/'
    end
    
    get '/' do
      redirect '/-shrtr-/'
    end
    
    private
    
    def current_user
      @current_user ||= user_from_cookie || user_from_api
    end
    
    def current_user=(user)
      @current_user = user
    end
    
    def signed_in?
      !current_user.nil?
    end
    
    def authenticate
      deny_access unless signed_in?
    end
    
    def sign_in(user)
      if user
        user.dont_you_forget_about_me
        set_cookie('remember_token', :value => user.remember_token,
          :expires => 1.year.from_now.utc)
        current_user = user
      end
    end
        
    def sign_out
      set_cookie('remember_token', :value => '',
        :expires => 1.day.ago.utc)
      current_user = nil
    end
    
    def deny_access
      redirect '/-shrtr-/login'
    end
    
    def user_from_cookie
      if token = request.cookies['remember_token']
        Shrtr::User.authenticate_by_remember_token(token)
      end
    end
    
    def user_from_api
      if key = params['api']
        Shrtr::User.authenticate_by_api(key)
      end
    end
  end  
end