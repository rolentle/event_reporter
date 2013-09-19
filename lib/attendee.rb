require_relative 'phone_number'

class Attendee
  attr_accessor :id, :regdate, :first_name, :last_name, :email_address, :homephone,:street, :city, :state, :zipcode

  def initialize(input={})
    @id =  clean_id(input[:id])
    @regdate = clean_regdate(input[:regdate]) 
    @first_name =clean_name(input[:first_name])
    @last_name = clean_name(input[:last_name])
    @homephone = clean_phone_number(input[:homephone])
    @email_address = clean_email_address(input[:email_address])
    @street = clean_street(input[:street])
    @city = clean_city(input[:city])
    @state = clean_state(input[:state])
    @zipcode = clean_zipcode(input[:zipcode])
  end

  def clean_id(id)
    id.to_s.strip
  end

  def clean_regdate(date)
    date.to_s.strip
  end  
  
  def clean_name(name)
    name.to_s.downcase.strip
  end

  def clean_zipcode(zipcode)
   return zipcode.to_s.downcase.strip.rjust(5,"0")[0..4]
  end

  def clean_phone_number(phone_number)
    phone_number.to_s.gsub!(/\D/, "") 
    
    if phone_number.length == 11 && phone_number[0] == "1"
      phone_number = phone_number[1..-1]
    elsif phone_number.length != 10
      phone_number = "0000000000"
    else
      phone_number
    end 
  end
 
  def clean_email_address(email_address)
    email_address.to_s.downcase.strip
  end

  def clean_street(street)
    street.to_s.downcase.strip
  end

  def clean_city(city)
    city.to_s.downcase.strip
  end

  def clean_state(state)
    state.to_s.downcase.strip
  end
end
