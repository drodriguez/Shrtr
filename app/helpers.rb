
module Shrtr
  
  module Helpers
    SIXTYTWO = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.freeze
    def to_s_62(i)
      return SIXTYTWO[i] if i < 62
      s = ''
      while i > 0
        s << SIXTYTWO[i.modulo(62)]
        i /= 62
      end
      s.reverse
    end
  end

end