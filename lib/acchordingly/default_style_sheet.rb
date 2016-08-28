require 'prawn'
require_relative '../acchordingly'

module Acchordingly
  class DefaultStyleSheet

    attr_reader :layout, :is_song_part_labeled
    attr_reader :title_align, :title_size, :title_style, :title_color
    attr_reader :subtitle_align, :subtitle_size, :subtitle_style, :subtitle_color
    attr_reader :song_part_label_align, :song_part_label_color, :song_part_label_size, :song_part_label_style
    attr_reader :lyric_color, :lyric_size, :lyric_style
    attr_reader :chord_color, :chord_size, :chord_style

    def initialize
      $stdout.puts 'Loading default stylesheet'
      @layout = '{title}
{subtitle}

{chord_diagrams}

{song}'
      @is_song_part_labeled = true
      @title_align = :center
      @title_size = 16
      @title_style = :bold
      @title_color = '00FF00'
      @subtitle_align = :center
      @subtitle_size = 12
      @subtitle_style = :italic
      @subtitle_color = '000000'
      @song_part_label_align = :left
      @song_part_label_size = 11
      @song_part_label_style = :italic
      @song_part_label_color = '000000'
      @lyric_size = 11
      @lyric_style = :normal
      @lyric_color = '000000'
      @chord_size = 11
      @chord_style = :bold
      @chord_color = 'FF0000'
    end

  end
end