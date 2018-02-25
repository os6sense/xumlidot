require 'optparse'
require 'optparse/time'
require 'ostruct'

module Xumlidot
  OptionsError = Class.new(StandardError)

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

      @options.title = 'Class Diagram'
      @options.model_name = 'My Model'
      @options.diagram_type = :dot
      @options.rails = false
      @options.debug = false
      @options.inheritence = true
      @options.composition = true
      @options.usage = true
      @options.split = 1
      @options.sequence = ''
      @options.exclude = ''

      ENV.delete("XUMLIDOT_DEBUG")

      opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: xumlidot.rb [options]"

        opts.separator ""
        opts.separator "Specific options:"

        opts.on("-t", "--title [TEXT]", "Title for the diagram") do |v|
          @options.title = v
        end

        opts.on("-m", "--model [TEXT]", "Model Name for the diagram") do |v|
          @options.model_name = v
        end

        opts.on("-d", "--dot", "Output diagram using dot (default)") do |v|
          @options.diagram_type = :dot
        end

        opts.on("-x", "--xmi", "Output diagram using xmi") do |v|
          @options.diagram_type = :xmi
        end

        opts.on("-d", "--[no-]debug", "Output debug information") do |v|
          @options.debug = v
          ENV["XUMLIDOT_DEBUG"] = '1'
        end

        opts.on("-i", "--[no-]inheritence", "Output inheritence links on the diagram") do |v|
          @options.inheritence = v
        end

        opts.on("-r", "--[no-]rails", "Expect a Rails application") do |v|
          @options.rails = v
        end

        opts.on("-c", "--[no-]composition", "Output composition links on the diagram") do |v|
          @options.composition = v
        end

        opts.on("-e", "--exclude [TEXT[", "Output usage links on the diagram") do |v|
          @options.exclude = v
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
