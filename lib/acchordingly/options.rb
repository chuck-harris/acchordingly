require 'optparse'
require 'ostruct'

module Acchordingly
  class Options

    attr_reader :song_files, :book_files

    def initialize( o_output, argv )
      @o_output = o_output
      @parameters = parse( argv )
    end

    private
      def parse( argv )

        @song_files = []
        @book_files = []

        OptionParser.new do |opts|
          opts.banner = 'Usage: acchordingly.rb [options]'

          opts.on( '-h', '--help', 'Show this message' ) do
            @o_output.puts opts.help
            exit
          end

          opts.on( '-s', '--song SONGFILE', 'Format a single song from the ChordPro file SONGFILE' ) do |song_file|
            @song_files << song_file
          end

          opts.on( '-b', '--book BOOKFILE', 'Format a song book defined by the file BOOKFILE' ) do |book_file|
            @book_files << book_file
          end

          begin
            if argv.empty?
              @o_output.puts opts.banner
              exit -1
            else
              opts.parse! argv
              if @song_files.size == 0 && @book_files.size == 0 then
                e = OptionParser::ParseError.new 'You must specify at least one song file or book file'
                throw e
              end
              opts
            end
          rescue OptionParser::ParseError => e
            @o_output.puts e.message
            exit -1
          end
        end
      end
  end
end
