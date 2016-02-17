require_relative '../acchordingly'

module Acchordingly
  class Runner

    attr_reader :pdfs, :pdf_names

    def initialize( o_output, argv )
      $stdout = o_output
      @options = Options.new( o_output, argv )
      @pdf_names = []
      @pdfs = []
    end

    def run
      @options.song_files.each do |song_file|
        document = Acchordingly::SongSheet.new song_file
        document.format
        @pdf_names << File.basename( song_file, '.pro' ) + '.pdf'
        @pdfs << document.pdf
      end

      @options.book_files.each do |book_file|
        document = Acchordingly::SongBook.new book_file
        document.format
        @pdf_names << File.basename( book_file, '.songbook' ) + '.pdf'
        @pdfs << document.pdf
      end
    end
  end
end
