require 'optparse'

module Acchordingly
  class Options
    def initialize( o_output, argv )
      @o_output = o_output
      parse( argv )
    end

    private
      def parse( argv )
        OptionParser.new do |opts|
          opts.banner = 'Usage: acchordingly.rb [options]'

          opts.on( '-h', '--help', 'Show this message' ) do
            @o_output.puts opts.help
            exit
          end

          begin
            if argv.empty?
              @o_output.puts opts.banner
            else
              opts.parse! argv
            end
          rescue OptionParser::ParseError => e
            @o_output.puts e.message
            exit -1
          end
        end
      end
  end
end
