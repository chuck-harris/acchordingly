require_relative 'options'

module Acchordingly
  class Runner
    def initialize( o_output, argv )
      @o_output = o_output
      @options = Options.new( o_output, argv )
    end

    def run

    end
  end
end
