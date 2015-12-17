require 'acchordingly/runner'

class OOutput

  def messages
    @messages ||= []
  end

  def puts( message )
    message.split( "\n" ).each do |line|
      messages << line
    end
  end

  def write( message )
    puts message
  end
end

def o_output
  @o_output ||= OOutput.new
end

Given(/^I am at the command line$/) do
  # ATM, there is nothing required here
end

When(/^I run the application with the arguments "([^"]*)"$/) do |args|
  begin
    argv = args.split
    acchordingly = Acchordingly::Runner.new( o_output, argv )
    acchordingly.run
  rescue SystemExit => e

  end
end


Then(/^I should see usage instructions$/) do
  expect( o_output.messages ).to include( 'Usage: acchordingly.rb [options]' )
end

Then(/^I should see complete instructions$/) do
  expect( o_output.messages ).to include( 'Usage: acchordingly.rb [options]' )
  expect( o_output.messages ).to include( '    -h, --help                       Show this message' )
  expect( o_output.messages ).to include( '    -s, --song SONGFILE              Format a single song from the ChordPro file SONGFILE' )
  expect( o_output.messages ).to include( '    -b, --book BOOKFILE              Format a song book defined by the file BOOKFILE' )
end

Then(/^I should see "([^"]*)"$/) do |arg1|
  expect( o_output.messages ).to include( arg1 )
end
