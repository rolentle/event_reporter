require 'minitest'
require 'minitest/autorun'
require './lib/event_reporter'
require 'minitest/pride'

class EventReporterTest < MiniTest::Test
  def test_it_exists
    er = EventReporter.new
    assert_kind_of EventReporter, er
  end

  def test_it_takes_commands
    skip
    command_help  = "help"
    er = EventReporter.new
    assert_equal "help", er.command(command_help)
  end
 
  def test_it_returns_commands_when_command_help
    commands = "load <filename>\nhelp\nhelp <command>\nqueue count\nqueue clear\nqueue print\nqueue print by <attribute>\nqueue save to <filename.csv>\nfind <attribute> <criteria>"
    er = EventReporter.new
    assert_equal commands, er.command("help")
  end

  def test_it_returns_load_description_command_help_load
    commands = "help load <filename>"
    er = EventReporter.new
    assert_equal "Erase any loaded data and parse the specified file. If no filename is given, default to event_attendees.csv.", er.command(commands)
  end

  def test_it_returns_queue_count_description_when_command_help_queue_count
    commands = "help queue count"
    er = EventReporter.new
    assert_equal "Output how many records are in the current queue.", er.command(commands)
 end

  def test_it_returns_queue_clear_description_when_command_help_queue_clear
    commands = "help queue clear"
    er = EventReporter.new
    assert_equal "Empties the queue.", er.command(commands)
  end

  def test_it_returns_queue_print_description_when_help_queue_print
     commands = "help queue print"
     er = EventReporter.new
     assert_equal "Print out a tab-delimited data table with a header row following this format:\nLAST NAME\tFIRST NAME\tEMAIL\tZIPCODE\tCITY\tSTATE\tADDRESS\tPHONE", er.command(commands)
  end

  def test_it_returns_queue_print_by_attribute_description_when_help_queue_print_attribute
    commands = "help queue print by <attribute>"
    er = EventReporter.new
    assert_equal "Print out a tab-delimited data table sorted by selected attribute:\nLAST NAME\nFIRST NAME\nEMAIL\nZIPCODE\nCITY\nSTATE\nADDRESS\nPHONE", er.command(commands)
  end

  def test_it_returns_queue_save_to_filname_csv_description_when_help_queue_save_to_filenam_csv
    commands = "help queue save to <filename.csv>"
    er = EventReporter.new
    assert_equal "Export the current queue to the specified filename as a CSV. The file should should include data and headers for last name, first name, email, zipcode, city, state, address, and phone number.", er.command(commands)
  end

  def test_it_returns_find_attribute_criteria_description_when_help_find_attribute_criteria
    commands = "help find <attribute> <criteria>"
    er = EventReporter.new
    assert_equal "Loads the queue with all records matching the criteria(case sensitive) for the given attribute:\nLAST NAME\nFIRST NAME\nEMAIL\nZIPCODE\nCITY\nSTATE\nADDRESS\nPHONE", er.command(commands)
  end
 
  def test_load_filename_is_valid
    skip
    filename = "race_horses.csv"
    commands = "load #{filename}"
    er = EventReporter.new
    assert_equal "loading race_horses.csv", er.command(commands)
  end   
  
  def test_load_filename_parse_data
    filename = "sample_event_attendees.csv"
    commands  = "load #{filename}"
    er = EventReporter.new
    assert_equal "Allison", er.command(commands).first[:first_name]
  end
  
  def test_it_loads_event_attendees_csv_as_default
    command = "load"
    er = EventReporter.new
    assert_equal "event_attendees.csv", er.command(command).path 
  end  

  def test_queue_count_is_a_valid_command
    skip
    command =  "queue count"
    er = EventReporter.new
    assert_equal "queue count", er.command(command)
  end

  def test_queue_count_returns_row_count
    er = EventReporter.new
    er.command("load sample_event_attendees.csv")
    assert_equal "0", er.command("queue count")
  end

  def test_queue_count_for_defaults
    er = EventReporter.new
    er.command("load")
    assert_equal "0", er.command("queue count")
  end

  def test_find_attribute_criteria_is_valid
    skip
    er = EventReporter.new
    assert_equal "finding first_name john", er.command("find first_name John")
  end

  def test_queue_count_for_find_id_3
    er = EventReporter.new
    er.command("load")
    er.command("find id 3 " )
    assert_equal "1", er.command("queue count")
  end
  
  def test_queue_count_for_find_first_name_john
    er = EventReporter.new
    er.command("load")
    er.command("find first_name John " )
    assert_equal "63", er.command("queue count")
  end
end
