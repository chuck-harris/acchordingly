require 'prawn'
require_relative 'song_document'
require_relative 'song_book_definition'
require_relative 'chord_pro_song'

module Acchordingly
  class SongBook < Acchordingly::SongDocument

    def initialize( song_book_file )
      super()
      @book = SongBookDefinition.new song_book_file
      @book.song_files.each do |song|
        @song_files << ChordProSong.new( song )
      end
      $stdout.puts "Loading songbook #{@book.title}"
    end

    def format
      @pdf = Prawn::Document.new

      super

    end
  end
end