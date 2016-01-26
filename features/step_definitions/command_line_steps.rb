require 'acchordingly/runner'
require 'pdf/inspector'
require 'stringio'
require 'chronic'

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
    @pdfs = acchordingly.pdfs
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

Then(/^I should see "([^"]*)"$/) do |message|
  expect( o_output.messages ).to include( message )
end

And(/^(\d+) pdfs? should be generated$/) do |pdf_count|
  expect( @pdfs.size ).to eq( pdf_count.to_i )
end

And(/^the ([^ ]*) pdf should have (\d+) pages?$/) do |ordinal, page_count|
  index = Chronic::Numerizer.numerize( ordinal ).to_i - 1
  page_analysis = PDF::Inspector::Page.analyze( @pdfs[index].render )
  expect( page_analysis.pages.size ).to eq( page_count.to_i )
end

And(/^the ([^ ]*) pdf should say "([^"]*)"$/) do |ordinal, content|
  index = Chronic::Numerizer.numerize( ordinal ).to_i - 1
  text_analysis = PDF::Inspector::Text.analyze( @pdfs[index].render )
  expect( text_analysis.strings).to include( content )
end
