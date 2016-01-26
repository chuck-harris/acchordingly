require 'prawn'
require_relative 'song_document'
require_relative 'default_style_sheet'

module Acchordingly
  class SongDocument < Prawn::Document

    attr_reader :pdf

    def initialize(stylesheet = DefaultStyleSheet.new)
      @song_files = []
      @stylesheet = stylesheet
    end

    def format
      @song_files.each do |song|
        if @pdf.nil?
          @pdf = Prawn::Document.new
        else
          @pdf.start_new_page
        end
        format_title song
        format_subtitle song
      end
    end

    def format_title(song)
      if song.title then
        @pdf.text song.title.strip,
                  :align => @stylesheet.title_align,
                  :size => @stylesheet.title_size,
                  :style => @stylesheet.title_style,
                  :color => @stylesheet.title_color
      end
    end

    def format_subtitle(song)
      if song.subtitle then
        @pdf.text song.subtitle.strip,
                  :align => @stylesheet.subtitle_align,
                  :size => @stylesheet.subtitle_size,
                  :style => @stylesheet.subtitle_style,
                  :color => @stylesheet.subtitle_color
      end
    end
  end
end