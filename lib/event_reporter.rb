require 'CSV'
require './lib/attendee'
require 'pry'

class EventReporter
 attr_accessor :queue, :attributes

  def initialize
   @queue = [] 
  end

  def run
    puts "Welcome to Event Reporter"
    input = "" 
    while input != 'quit'
      print "Enter command:"
      input = gets.chomp
      command(input)
    end
  end

  def command(input)
    words = input.split(" ")
    command = words[0]
    if command == "help"
      help_router(input)
    elsif command == "load"
      file_loader(words[1]) 
    elsif command == "queue"
      queue_router(input)
    elsif command == "find"
      find(words[1], words[2..-1].join(''))
    elsif command == 'quit'
      'Thank you for using Event Reporter'
    else 
      "That is an invalid command see 'help' for list off all commands"
    end
  end

  def queue_router(input)
       
     if input == 'queue count'
       queue_count
     elsif input == 'queue clear'
       queue_clear
     elsif input.include? 'queue print'
       words = input.split(' ')
         if words.length == 2
           queue_print
         else
           queue_print_by(words[-1])
         end
     elsif input.start_with?('queue save to')
       queue_save_to(input.split(' ')[-1])
     else
       "Not a valid queue command."
     end
  end

   def attributes
     {"id" => {"alignment" => 12},
     "last_name"=> {"alignment" => 12},
     "first_name"=> {"alignment" => 12},
     "email_address"=> {"alignment" => 44},
     "zipcode"=> {"alignment" => 12},
     "city"=> {"alignment" => 12},
     "street"=> {"alignment" => 40},
     "state"=> {"alignment" => 12},
     "homephone"=> {"alignment" => 12}}
  end
  def help_router(input)
     if  input == "help"
       puts "The acceptable commands are:\n#{commands.collect { |k,v| "#{k.ljust(20)}\t#{v}"}.join("\n")}"
     else 
       help_command = input.split[1..-1].join(" ") 
        puts commands[help_command]
     end 
  end

  def commands
    {"load <filename>"=>
    "Erase any loaded data and parse the specified file. If no filename is given, default to event_attendees.csv.",
    "queue count" => 
    "Output how many records are in the current queue.",
    "queue clear" =>
    "Empties the queue.",
    "queue print"=> 
    "Print out a tab-delimited data table with a header row following this format:\n\t#{attributes.keys[1..-1].join("\n  \t")}",
    "queue print by <attribute>" =>
    "Print out a tab-delimited data table sorted by selected attribute:\n\t#{attributes.keys[1..-1].join("\n  \t")}",
    "queue save to <filename.csv>" => 
    "Export the current queue to the specified filename as a CSV. The file should should include data and headers",
    "find <attribute> <criteria>"=>
    "Loads the queue with all records matching the criteria(case sensitive) for the given attribute:\n\t#{attributes.keys[1..-1].join("\n  \t")}"}
  end

  def file_loader(filename)
    filename ||= "event_attendees.csv"
  
    input_file = CSV.read filename, headers: true, header_converters: :symbol
  return  @loaded_array = map_csv_attendees_instant_variables_to_hash(input_file)
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
    header =  attributes.collect { |k,v| "#{k.center(v['alignment'])}" }.join("\t")
    data = queue.collect do |row|
      attributes.collect { |k,v| "#{row[k].center(v['alignment'])}" }.join("\t")   
    end

    results = header + "\n" + data.join("\n")
    puts results
    return results
  end

  def queue_print_by(attribute)
    attribute = attribute.downcase
    @queue = @queue.sort_by { |row| row[attribute] }
    return  queue_print
  end

  def queue_clear
    @queue = {}  
  end
  
  def queue_save_to(filename)
     new_file = File.open filename,"w"
     new_file.write(queue_print)
     puts "Writing #{filename}"
     new_file.close
     puts "#{filename} written."
  end


  def find(input_attribute, criteria)
   criteria = criteria.to_s.rstrip.downcase
   @queue = @loaded_array.select { |attendee| attendee[input_attribute] == criteria}
  end
end
