require 'prawn'
require_relative '../acchordingly'

module Acchordingly
  class DefaultStyleSheet

    attr_reader :layout
    attr_reader :title_align, :title_size, :title_style, :title_color
    attr_reader :subtitle_align, :subtitle_size, :subtitle_style, :subtitle_color

    def initialize
      $stdout.puts 'Loading default stylesheet'
      @layout = '{title}
{subtitle}

{chord_diagrams}

{song}'
      @title_align = :center
      @title_size = 18
      @title_style = :bold
      @title_color = '00FF00'
      @subtitle_align = :center
      @subtitle_size = 14
      @subtitle_style = :italic
      @subtitle_color = '000000'
    end

  end
end