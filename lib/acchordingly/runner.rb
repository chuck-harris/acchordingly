require_relative '../acchordingly'

module Acchordingly
  class Runner

    attr_reader :pdfs

    def initialize( o_output, argv )
      $stdout = o_output
      @options = Options.new( o_output, argv )
      @pdfs = []
    end

    def log( message )
      $stdout.puts message
    end

    def run

      @options.song_files.each do |song_file|
        document = Acchordingly::SongSheet.new song_file
        @pdfs << document.pdf
      end

      @options.book_files.each do |book_file|
        document = Acchordingly::SongBook.new book_file
        @pdfs << document.pdf
      end
    end
  end
end
