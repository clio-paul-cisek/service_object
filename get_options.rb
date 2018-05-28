# frozen_string_literal: true

class GetOptions
  def initialize
    @options = {}
    @parser = setup_parser
  end

  def call
    parser.parse!
    options
  rescue OptionParser::InvalidOption
    print_options_and_exit(parser)
  end

  private

  attr_reader :options, :parser

  def setup_parser
    OptionParser.new do |parser|
      description(parser)
      html_csv_option(parser)
      help_option(parser)
    end
  end

  def description(parser)
    parser.banner = 'Usage: app [options] [directory_to_scan]'
    parser.separator('options:')
  end

  def html_csv_option(parser)
    parser.on(
      '--output [OUTPUT]',
      %i[csv html],
      'Select output raport type (csv, html). CSV is default option'
    ) do |output|
      @options[:output] = output
    end
  end

  def help_option(parser)
    parser.on_tail('-h', '--help', 'Shows available options') do |_help|
      print_options_and_exit(parser)
    end
  end

  def print_options_and_exit(parser)
    puts parser
    exit
  end
end
