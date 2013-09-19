require "minitest/autorun"
require './lib/phone_number'

class PhoneNumberTest < MiniTest::Test

  def test_it_exists
    phone_number = PhoneNumber.new
    assert_kind_of PhoneNumber, phone_number
  end
  
  def test_it_is_initialized_from_a_phone_number
    number = '4236466119'
    pn = PhoneNumber.new(number)
    assert_equal '4236466119', pn.phone_number
  end

  def test_it_can_change_phone_numbers
    number =  '2024556677'
    pn = PhoneNumber.new(number)
    assert_equal number, pn.phone_number
    pn.phone_number = "5555555555"
    assert_equal "5555555555", pn.phone_number
  end
  def test_it_cleans_up_phone_numbers_with_periods_and_hyphens
    pn = PhoneNumber.new( '202.444.9382')
    assert_equal '2024449382', pn.phone_number
  end

  def test_it_cleans_up_phone_numbers_with_spaces_and_parentheses
    pn = PhoneNumber.new('(202) 444 9382')
    assert_equal '2024449382', pn.phone_number
  end

  def test_it_removes_leading_one_from_an_eleven_digit_phone_number    
   pn = PhoneNumber.new('12024449382')
   assert_equal '2024449382', pn.phone_number
  end

  def test_it_throws_away_numbers_that_are_too_long   
    pn = PhoneNumber.new('23334445555')
    assert_equal '0000000000', pn.phone_number
  end

  def test_it_throws_away_numbers_that_are_too_long   
    pn = PhoneNumber.new('222333444')
    assert_equal '0000000000', pn.phone_number
  end
end
