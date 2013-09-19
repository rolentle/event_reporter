require_relative 'phone_number'

class Attendee
  attr_accessor :id, :regdate, :first_name, :last_name, :email_address, :homephone,:street, :city, :state, :zipcode

  def initialize(input={})
    @id =  input[:id].nil? ? "" : input[:id].strip 
    @regdate = input[:regdate].nil? ? "" :  input[:regdate].strip 
    @first_name =  input[:first_name].nil? ?  "" : input[:first_name].downcase.strip 
    @last_name = input[:last_name].nil? ? "" : input[:last_name].downcase.strip 
    @homephone = input[:homephone].nil? ? "0000000000" : clean_phone_number(input[:homephone])
    @email_address = input[:email_address].nil? ? "" : input[:email_address].downcase.strip 
    @street = input[:street].nil? ? "" : input[:street].downcase.strip 
    @city = input[:city].nil? ? "" : input[:city].downcase.strip 
    @state = input[:state].nil? ? "" : input[:state].downcase.strip 
    @zipcode = input[:zipcode].nil? ? "" : clean_zipcode(input[:zipcode].downcase.strip)
  end

  def clean_zipcode(zipcode)
   return zipcode.to_s.rjust(5,"0")[0..4]
  end

  def clean_phone_number(phone_number)
    phone_number.gsub!(/\D/, "") 
    
    if phone_number.length == 11 && phone_number[0] == "1"
      phone_number = phone_number[1..-1]
    elsif phone_number.length != 10
      phone_number = "000000000"
    else
      phone_number
    end 
  end
end
