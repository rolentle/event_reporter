class Zipcode
  attr_accessor :zipcode

  def initialize(zipcode=nil)
    @zipcode = zipcode.to_s.rjust(5, "0")[0..4]
  end

end
