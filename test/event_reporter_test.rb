require 'minitest'
require 'minitest/autorun'
require './lib/event_reporter'

class EventReporterTest < MiniTest::Test
  def test_it_exists
    er = EventReporter.new
    assert_kind_of EventReporter, er
  end

  def test_it_takes_commands
    command_help  = "help"
    er = EventReporter.new
    assert_equal "help", command
  end
end
