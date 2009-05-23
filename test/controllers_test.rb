require 'test_helper'

class ControllersTest < Test::Unit::TestCase
  
  def test_index_response_ok
    get '/'
    assert last_response.ok?
  end
  
end