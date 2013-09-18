require 'CSV'

class EventReporter
 attr_accessor :queue

  def initialize
   @queue = Array.new 
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
      queue_count
    elsif command == "find"
      find(words[1], words[2])
    else 
      "That is an invalid command see 'help' for list off all commands"
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
    input_file = CSV.open filename, headers: true, header_converters: :symbol
    @csv = Attendee.new(input_file)
  end  

  def queue_count
   queue.count.to_s
  end

  def find(attribute, criteria)
    criteria = criteria.to_s.downcase.rstrip
   @queue = @csv.find_all { |row| row[attribute.to_sym] == criteria }
  end
end
