require 'optparse'
require 'optparse/time'
require 'ostruct'

module Xumlidot
  OptionsError = Class.new(StandardError)

  # Options is global to prevent us having to pass it around everywhere.
  # make Singleton too? 
  class Options
    def self.method_missing(m, *args, &block) 
      if @options.respond_to?(m)
        @options.send(m) 
      else
        raise OptionsError.new("Unknown Option #{m}")
      end
    end

    def self.parse(args)
      @options = OpenStruct.new

      @options.rails = false
      @options.dot = false
      @options.xmi = false
      @options.debug = false
      @options.inheritence = true
      @options.composition = true
      @options.usage = true
      @options.split = 1
      @options.sequence = ''

      opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: xumlidot.rb [options]"

        opts.separator ""
        opts.separator "Specific options:"

        opts.on("-r", "--[no-]rails", "Expect a Rails application") do |v|
          @options.rails = v
        end

        opts.on("-d", "--[no-]dot", "Output diagram using dot") do |v|
          @options.dot = v
        end

        opts.on("-x", "--[no-]xmi", "Output diagram using xmi") do |v|
          @options.xmi = v
        end

        opts.on("-x", "--[no-]debug", "Output debug information") do |v|
          @options.debug = v
        end

        opts.on("-i", "--[no-]inheritence", "Output inheritence links on the diagram") do |v|
          @options.inheritence = v
        end

        opts.on("-c", "--[no-]composition", "Output composition links on the diagram") do |v|
          @options.composition = v
        end

        opts.on("-u", "--[no-]usage", "Output usage links on the diagram") do |v|
          @options.usage = v
        end
        opts.separator ""

        opts.separator "Common options:"

        # No argument, shows at tail.  This will print an options summary.
        # Try it and see!
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end

        # Another typical switch to print the version.
        opts.on_tail("--version", "Show version") do
          puts ::Version.join('.')
          exit
        end
      end

      opt_parser.parse!(args)
      @options
    end

  end
end
