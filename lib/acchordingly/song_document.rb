require 'prawn'
require_relative 'song_document'
require_relative 'default_style_sheet'
require_relative 'chord'

module Acchordingly
  class SongDocument < Prawn::Document

    attr_reader :pdf

    def initialize(stylesheet = DefaultStyleSheet.new)
      @song_files = []
      @stylesheet = stylesheet
      @chord_library = {'Am' => Chord.new('Am', 0, 4, [2, 0, 0, 0], '2000'),
                        'C' => Chord.new('C', 0, 4, [0, 0, 0, 3], '0003'),
                        'D7' => Chord.new('D7', 0, 4, [2, 0, 2, 0], '1030'),
                        'Dm' => Chord.new('Dm', 0, 4, [2, 2, 1, 0], '3210'),
                        'Em' => Chord.new('Em', 0, 4, [0, 4, 3, 2], '0321'),
                        'F' => Chord.new('F', 0, 4, [2, 0, 1, 0], '2010'),
                        'Fm' => Chord.new('Fm', 0, 4, [1, 0, 1, 3], '1024'),
                        'G' => Chord.new('G', 0, 4, [0, 2, 3, 2], '0132'),
                        'G7' => Chord.new('G7', 0, 4, [0, 2, 1, 2], '0213')
      }
    end

    def format
      @song_files.each do |song|
        if @pdf.nil?
          @pdf = Prawn::Document.new
        else
          @pdf.start_new_page
        end
        @stylesheet.layout.each_line do |line|
          line.strip!
          if line =~ /^$/
            @pdf.text ' '
          end
          if line =~ /\{title\}/
            format_title song
          end
          if line =~ /\{subtitle\}/
            format_subtitle song
          end
          if line =~ /\{chord_diagrams\}/
            format_chord_diagrams song
          end
          if line =~ /\{song\}/
            format_song song
          end
        end
      end
    end

    def format_title(song)
      if song.title
        @pdf.text song.title.strip,
                  :align => @stylesheet.title_align,
                  :size => @stylesheet.title_size,
                  :style => @stylesheet.title_style,
                  :color => @stylesheet.title_color
      end
    end

    def format_subtitle(song)
      if song.subtitle
        @pdf.text song.subtitle.strip,
                  :align => @stylesheet.subtitle_align,
                  :size => @stylesheet.subtitle_size,
                  :style => @stylesheet.subtitle_style,
                  :color => @stylesheet.subtitle_color
      end
    end

    def format_chord_diagrams(song)
      chord_line = @pdf.cursor
      @pdf.bounding_box([72, chord_line], :width => 468, :height => 50) do
        #@pdf.stroke_bounds
        x = 0
        song.chords.sort.each do |chord|
          draw_chord chord, x, 50
          x += 50
        end
      end
    end

    def format_song(song)
      song_parts = Hash.new
      left_starting_point = 0
      chord_height = @pdf.height_of 'C', :size => @stylesheet.chord_size, :style => @stylesheet.chord_style
      if @stylesheet.is_song_part_labeled
        left_starting_point = @pdf.width_of 'chorus 10  ', :style => @stylesheet.song_part_label_style, :size => @stylesheet.song_part_label_size
      end
      in_chorus = false
      chorus = ''
      song.chord_pro.each_line do |line|
        line.strip!
        if in_chorus
          chorus << line
        end

        default_print = true
        if line =~ /\{title:.*\}/
          default_print = false
        end

        if line =~ /\{subtitle:.*\}/
          default_print = false
        end

        if line =~ /\{comment:.*\}/
          # this line contains comments or performance notes
          tokens = /^(?<leader>[^\{\}]*)\{comment:(?<comment>[^\}]*)\}(?<trailer>.*)$/.match line
          leader, comment, trailer = tokens.captures
          @pdf.text comment.strip, :size => 12, :style => :bold
          default_print = false
        end

        if line =~ /^$/
          default_print = false
          @pdf.text ' '
        end

        if line =~ /\{(chorus|verse|bridge|intro|outro|coda)\}/
          tokens = /\{(chorus|verse|bridge|intro|outro|coda)\}/.match line
          song_part = tokens.captures
          if song_parts[song_part].nil?
            song_parts[song_part] = 0
          end
          song_parts[song_part] += 1
          line_vertical_position = @pdf.cursor - chord_height
          @pdf.text_box "#{song_part[0].capitalize} #{song_parts[song_part]}", :at => [0, line_vertical_position], :size => @stylesheet.song_part_label_size,
                        :style => @stylesheet.song_part_label_style, :color => @stylesheet.song_part_label_color
          default_print = false
        end

        if line =~ /\[[^\]]+\]/
          # this line contains at least one chord
          @pdf.text ' '
        end

        if line =~ /(\{start_of_chorus\}|\{soc\})/
          in_chorus = true
          default_print = false
        end

        if line =~ /(\{end_of_chorus\}|\{eoc\})/
          in_chorus = false
          default_print = false
        end

        if line =~ /\{chorus\}/
          #TODO properly render the chorus
          #@pdf.text chorus
        end

        if default_print
          tokens = line.split /(\[[^\]]*\])/
          line_vertical_position = @pdf.cursor
          chord_vertical_position = @pdf.cursor + chord_height
          horizontal_position = left_starting_point
          last_token_was_chord = false
          last_token_width = 0
          tokens.each do |token|
            if !token.strip.empty?
              if token.start_with? '['
                chord_name = token.match( /[^\[\]\*]+/ )[0]
                if last_token_was_chord
                  horizontal_position += last_token_width
                end
                @pdf.formatted_text_box [:text => chord_name, :color => @stylesheet.chord_color], :at => [horizontal_position, chord_vertical_position], :style => @stylesheet.chord_style, :size => @stylesheet.chord_size
                last_token_was_chord = true
                last_token_width = @pdf.width_of chord_name + '  ', :style => @stylesheet.chord_style, :size => @stylesheet.chord_size
              else
                width = @pdf.width_of token, :size => @stylesheet.lyric_size, :style => @stylesheet.lyric_style
                @pdf.text_box token, :at => [horizontal_position, line_vertical_position], :size => @stylesheet.lyric_size, :style => @stylesheet.lyric_style, :color => @stylesheet.lyric_color
                horizontal_position += width
                last_token_was_chord = false
              end
            end
          end
          @pdf.text ' '
        end
      end
    end

    def draw_chord(chord_name, x, y)
      chord = @chord_library[chord_name]
      if chord.nil?
        puts "Unknown chord #{chord_name}"
      else
        name_height = @pdf.height_of('C', :size => 10, :style => :bold)

        @pdf.bounding_box([x, y], :width => 30, :height => (name_height + 36)) do
          #@pdf.stroke_bounds
          @pdf.text chord.name, :align => :center, :size => 10, :style => :bold
          @pdf.stroke do
            @pdf.rectangle [6, 36], 18, 24
            @pdf.vertical_line 12, 36, :at => 12
            @pdf.vertical_line 12, 36, :at => 18
            @pdf.horizontal_line 6, 24, :at => 18
            @pdf.horizontal_line 6, 24, :at => 24
            @pdf.horizontal_line 6, 24, :at => 30
          end

          if chord.base_fret > 0
            @pdf.draw_text chord.base_fret, :at => [26, 33], :size => 6
          end

          string_x = 6
          chord.strings.each do |fret|
            if fret == -1
              @pdf.stroke_line [string_x - 2, 37], [string_x + 2, 41]
              @pdf.stroke_line [string_x + 2, 37], [string_x - 2, 41]
            elsif fret == 0
              @pdf.stroke_circle [string_x, 39], 2
            else
              @pdf.fill_circle [string_x, 39 - (fret - chord.base_fret) * 6], 2
              @pdf.stroke
            end
            string_x += 6
          end

          string_x = 6
          chord.fingering.each_char do |finger|
            if finger != '0'
              @pdf.draw_text finger, :at => [string_x - 2, 6], :size => 6
            end
            string_x += 6
          end
        end
      end
    end
  end
end