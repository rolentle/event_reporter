require 'CSV'
require './lib/attendee'
require 'pry'
class EventReporter
 attr_accessor :queue, :attributes

  def initialize
   @queue = {} 
  end
  def command(input)
    words = input.split(" ")
    command = words[0]
    if command == "help"
      help_router(input)
    elsif command == "load"
      # return "loading #{words[1]}"
      file_loader(words[1]) 
    elsif command == "queue"
      queue_router(input)
    elsif command == "find"
      find(words[1], words[2])
    else 
      "That is an invalid command see 'help' for list off all commands"
    end
  end

  def queue_router(input)
     if input == 'queue count'
       queue_count
     elsif input == 'queue clear'
       queue_clear
     elsif input == 'queue print'
       queue_print
     elsif input.start_with?('queue save to')
       queue_save_to(input.split(' ')[-1])
     else
       "Not a valid queue command."
     end
  end

  def help_router(command)
     if  command == "help"
      "load <filename>\nhelp\nhelp <command>\nqueue count\nqueue clear\nqueue print\nqueue print by <attribute>\nqueue save to <filename.csv>\nfind <attribute> <criteria>" 
    elsif command == "help load <filename>"
      "Erase any loaded data and parse the specified file. If no filename is given, default to event_attendees.csv."
    elsif command == "help queue count"
      "Output how many records are in the current queue."
    elsif command == "help queue clear"
      "Empties the queue."
    elsif command == "help queue print"
      "Print out a tab-delimited data table with a header row following this format:\nLAST NAME\tFIRST NAME\tEMAIL\tZIPCODE\tCITY\tSTATE\tADDRESS\tPHONE"
    elsif command == "help queue print by <attribute>"
      "Print out a tab-delimited data table sorted by selected attribute:\nLAST NAME\nFIRST NAME\nEMAIL\nZIPCODE\nCITY\nSTATE\nADDRESS\nPHONE"
    elsif command == "help queue save to <filename.csv>"
      "Export the current queue to the specified filename as a CSV. The file should should include data and headers for last name, first name, email, zipcode, city, state, address, and phone number."
    elsif command == "help find <attribute> <criteria>"
      "Loads the queue with all records matching the criteria(case sensitive) for the given attribute:\nLAST NAME\nFIRST NAME\nEMAIL\nZIPCODE\nCITY\nSTATE\nADDRESS\nPHONE"
    end
  end

  def file_loader(filename)
    filename ||= "event_attendees.csv"
  
    input_file = CSV.read filename, headers: true, header_converters: :symbol
    @loaded_array = map_csv_attendees_instant_variables_to_hash(input_file)
  end  

  def map_csv_attendees_instant_variables_to_hash(csv_file)
    csv_file.collect do |row|
      attendee =  Attendee.new(row.to_hash)
      attendee_hash = {}
      attendee.instance_variables.each do |var|
        attendee_hash[var.to_s.delete("@")] = attendee.instance_variable_get(var)
       end
       attendee_hash
    end
  end

  def queue_count
    puts  queue.count.to_s || "queue count error"
  end

  def queue_print
     header = "\t#{'LAST NAME'.center(12, ' ')}\t#{'FIRST NAME'.center(12, ' ')}\t#{'EMAIL'.center(44, ' ')}\t#{'ZIPCODE'.center(12, ' ')}\t#{'CITY'.center(12, ' ')}\t#{'STATE'.center(12, ' ')}\t#{'ADDRESS'.center(40, ' ')}\t#{'PHONE'.center(12, ' ')}"
      data = queue.collect do |row|
      "\t#{row['last_name'].center(12, ' ')}\t#{row['first_name'].center(12, ' ')}\t#{row['email_address'].center(44, ' ')}\t#{row['zipcode'].center(12, ' ')}\t#{row['city'].center(12, ' ')}\t#{row['state'].center(12, ' ')}\t#{row['street'].center(40, ' ')}\t#{row['homephone'].center(12, ' ')}"
    end
   
    results = header + "\n" + data.join("\n")
    return results
  end

  def queue_print_by(attribute)
    attribute = attribute.downcase
    @queue = @queue.sort_by { |row| row[attribute] }
    queue_print
  end
  def queue_clear
    @queue = {}  
  end
  
  def queue_save_to(filename)
     new_file = File.open filename,"w"
     new_file.write(queue_print)
     new_file.close
  end

  def attributes
     ["id", "first_name", "last_name", "email_address","zipcode", "homephone", "address", "city", "state"]
  end

  def find(input_attribute, criteria)
   criteria = criteria.to_s.rstrip
   # dc_attribute =  attributes.find { |attribute| attribute.eql?(input_attribute.downcase)}
   @queue = @loaded_array.select { |attendee| attendee[input_attribute] == criteria}
  end
end
