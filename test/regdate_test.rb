require 'minitest'
require 'minitest/autorun'
require './lib/regdate'

class RegdateTest < MiniTest::Test

 def  test_it_exists
   rd = Regdate.new
   assert_kind_of Regdate, rd
 end

 def test_it_initialzes_with_date
  rd = Regdate.new
 end
end
