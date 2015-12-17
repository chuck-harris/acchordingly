require 'prawn'
require_relative 'song_document'
require_relative 'song_book_definition'

module Acchordingly
  class SongBook < Acchordingly::SongDocument

    def initialize( song_book_file )
      @book = SongBookDefinition.new song_book_file
      $stdout.puts "Loading songbook #{@book.title}"
    end
  end
end