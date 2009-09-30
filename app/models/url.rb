require 'uri'

module Shrtr  
  class URL    
    class << self
      attr :db
      
      def connect!(db)
        @db ||= db
      end
      
      def find_by_url(url)
        url = "http://#{url}" unless /^[^:]+:\/\// =~ url
        
        shrtr_id = @db.execute { |db| db["url:#{URI.escape(url)}"] }
        new(url, shrtr_id)
      end
      
      def find_by_shrtr_id(shrtr_id)
        url = @db.execute { |db| db["shrtr_id:#{shrtr_id}"] }
        new(url, shrtr_id) if url
      end
    end
    
    attr_reader :url
    attr_reader :shrtr_id
    
    def initialize(url, shrtr_id = nil)
      @url, @shrtr_id = url, shrtr_id
      if @shrtr_id.nil?
        @shrtr_id = to_s_62(Shrtr::URL.db.execute { |db| db.incr('shrtr_id-global:next_shrtr_id') })
        Shrtr::URL.db.execute { |db| db["shrtr_id:#{@shrtr_id}"] = @url }
        Shrtr::URL.db.execute { |db| db["url:#{URI.escape(@url)}"] = @shrtr_id }
      end
    end
    
    private
    
    SIXTYTWO = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.freeze
    def to_s_62(i)
      return SIXTYTWO[i,1] if i < 62
      s = ''
      while i > 0
        s << SIXTYTWO[i.modulo(62)]
        i /= 62
      end
      s.reverse
    end
    
  end
end