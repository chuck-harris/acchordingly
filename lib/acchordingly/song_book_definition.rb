module Acchordingly
  class SongBookDefinition

    attr_reader :title

    def initialize( song_book_file )
      @file_name = song_book_file
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
      end
    end
  end
end