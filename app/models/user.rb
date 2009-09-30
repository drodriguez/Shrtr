require 'digest/sha1'

module Shrtr
  class User
    class << self
      attr_writer :username
      attr_writer :password
      attr_writer :api_key
      
      def authenticate(username, password)
        user = self.create_user(username)
        return user if user.authenticated?(password)
      end
      
      def authenticate_by_remember_token(token)
        if @db['user:remember_token'] == token
          self.create_user
        end
      end
      
      def authenticate_by_api_key(key)
        user = self.create_user
        return user if user.api_authenticated?(key)
      end
      
      def create_user(username)
        return nil unless username == @username
        self.new(@username, @password, @api_key)
      end
    end
    
    attr :remember_token
    
    def initialize(username, password, api_key)
      @username, @password, @api_key, @remember_token = username, password, api_key, nil
    end
        
    def authenticated?(password)
      @password == Digest::SHA1.hexdigest(password)
    end
    
    def api_authenticated?(key)
      @api_key == key
    end
    
    def dont_you_forget_about_me
      self.remember_token = Digest::SHA1.hexdigest("--#{Time.now.utc}--#{encrypted_password}--")
    end
    
    def remember_token=(value)
      @db['user:remember_token'] = @remember_token = value
    end
  end
end