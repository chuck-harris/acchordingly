require_relative '../acchordingly'

module Acchordingly
  class Runner
    def initialize( o_output, argv )
      $stdout = o_output
      @options = Options.new( o_output, argv )
    end

    def log( message )
      $stdout.puts message
    end

    def run

      if @options.song_file then
        @document = Acchordingly::SongSheet.new @options.song_file
      elsif @options.book_file then
        @document = Acchordingly::SongBook.new @options.book_file
      end

    end
  end
end
