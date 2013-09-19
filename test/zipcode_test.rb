require 'minitest/autorun'
require './lib/zipcode'

class ZipcodeTest < MiniTest::Test
  def test_it_exists
    z = Zipcode.new
    assert_kind_of Zipcode, z
  end
  
  def test_it_initizalizes_with_a_zipcode
    zipcode = '37620'
    z = Zipcode.new(zipcode)
    assert_equal '37620', z.zipcode
  end

  def test_if_zipcode_is_a_string
    zipcode = 37620
    z = Zipcode.new(zipcode)
    assert_kind_of String, z.zipcode
  end

  def test_it_can_change_zipcode
    zipcode = '37620'
    z = Zipcode.new(zipcode)
    z.zipcode = '00000'
    assert_equal '00000', z.zipcode
  end
 
  def test_it_deletes_more_than_5_digits_from_the_right
    zipcode = '376201'
    z = Zipcode.new(zipcode)
    assert_equal '37620', z.zipcode
  end
end
