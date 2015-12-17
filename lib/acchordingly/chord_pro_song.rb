module Acchordingly

  class ChordProSong

    attr_reader :title, :subtitle

    def initialize( chord_pro_filename )
      @file_name = chord_pro_filename
      self.preparse
    end

    def preparse
      @chord_pro = open( @file_name ).read
      @chord_pro.each_line do |line|
        line.strip!
        if line =~ /\{title:.*\}/
          # this line contains the song title
          tokens = /^(?<leader>[^\{\}]*)\{title:(?<title>[^\}]*)\}(?<trailer>.*)$/.match line
          leader, @title, trailer = tokens.captures
        end

        if line =~ /\{subtitle:.*\}/
          # this line generally contains the composer or performer
          tokens = /^(?<leader>[^\{\}]*)\{subtitle:(?<subtitle>[^\}]*)\}(?<trailer>.*)$/.match line
          leader, @subtitle, trailer = tokens.captures
        end
      end
    end
  end
end