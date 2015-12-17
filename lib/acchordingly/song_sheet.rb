require 'prawn'
require_relative '../acchordingly'

module Acchordingly
  class SongSheet < SongDocument

    def initialize(song_file)
      song = ChordProSong.new song_file
      @song_files = [song]
      $stdout.puts "Parsing song #{song.title}"
    end

    def format

    end
  end
end