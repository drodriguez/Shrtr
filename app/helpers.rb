
module Shrtr
  
  module Helpers    
    def h(text)
      Rack::Utils.escape_html(text)
    end
  end

end