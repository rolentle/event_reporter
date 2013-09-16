class EventReporter
  def command(command)
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
    end
  end
end
