
module Shrtr
  class TokyoBackend
    def initialize(dbpath)
      @dbpath = dbpath
    end
    
    def execute(&block)
      @db ||= Rufus::Tokyo::Cabinet.new(@dbpath)
      yield @db
    ensure
      @db.close
      @db = nil
    end
  end
end