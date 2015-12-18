require 'prawn'
require_relative 'song_document'

module Acchordingly
  class SongDocument < Prawn::Document

    attr_reader :pdf

    def initialize
      @pdf = Prawn::Document.new
    end

  end
end