require 'uri'

module Shrtr
  include URI::Escape
  
  class URL
    class << self
      attr :db
      
      def connect!(conf)
        @db = Rufus::Tokyo::Cabinet.new(conf['dbname'])
      end
      
      def find_by_url(url)
        url = "http://#{url}" unless /^[^:]+:\/\// =~ url
        
        shrtr_id = @db["url:#{escape(url)}"]
        new(url, shrtr_id)
      end
      
      def find_by_shrtr_id(shrtr_id)
        url = @db["shrtr_id:#{shrtr_id}"]
        new(url, shrtr_id) if url
      end
    end
    
    attr_reader :url
    attr_reader :shrtr_id
    
    def initialize(url, shrtr_id = nil)
      @url, @shrtr_id = url, shrtr_id
      if @shrtr_id.nil?
        @shrtr_id = db.incr('shrtr_id-global:next_shrtr_id')
        @db["shrtr_id:#{@shrtr_id}"] = @url
        @db["url:#{escape(@url)}"] = @shrtr_id
      end
    end
  end
end