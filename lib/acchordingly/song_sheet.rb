require 'prawn'
require_relative '../acchordingly'

module Acchordingly
  class SongSheet < SongDocument

    def initialize(song_file)
      super()
      song = ChordProSong.new song_file
      @song_files << song
      $stdout.puts "Parsing song #{song.title}"
    end
  end
end