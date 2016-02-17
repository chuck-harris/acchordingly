module Acchordingly
  class Chord
    attr_accessor :name, :base_fret, :frets_shown, :strings, :fingering

    def initialize(name, base_fret, frets_shown, strings, fingering)
      @name = name
      @base_fret = base_fret
      @frets_shown = frets_shown
      @strings = strings
      @fingering = fingering
    end
  end
end
