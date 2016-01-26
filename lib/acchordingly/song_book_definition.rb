module Acchordingly
  class SongBookDefinition

    attr_reader :title, :song_files

    def initialize( song_book_file )
      @file_name = song_book_file
      @song_files = []
      self.preparse
    end

    def preparse
      definition = open( @file_name ).read
      definition.each_line do |line|
        line.strip!
        if line =~ /\{title:.*\}/
          # this line contains the book title
          tokens = /^(?<leader>[^\{\}]*)\{title:(?<title>[^\}]*)\}(?<trailer>.*)$/.match line
          leader, @title, trailer = tokens.captures
        end

        if line =~ /\{song:.*\}/
          # this line contains a song file for inclusion
          tokens = /^(?<leader>[^\{\}]*)\{song:(?<song>[^\}]*)\}(?<trailer>.*)$/.match line
          leader, song, trailer = tokens.captures
          @song_files << song
        end
      end
    end
  end
end