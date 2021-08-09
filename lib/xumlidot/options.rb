# frozen_string_literal: true

require 'optparse'
require 'optparse/time'
require 'ostruct'

module Xumlidot
  OptionsError = Class.new(StandardError)

  class Options
    @options = nil

    class << self
      attr_accessor :options

      def method_missing(method_name, *_args, &_block)
        return options.send(method_name) if options.respond_to?(method_name)

        raise OptionsError.new, "Unknown Option #{method_name}"
      end
    end

    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize
    def self.parse(args)
      @options = OpenStruct.new

      @options.title = 'Class Diagram'
      @options.model_name = 'My Model'
      @options.diagram_type = :dot
      @options.rails = false
      @options.debug = false
      @options.inheritance = true
      @options.composition = true
      @options.usage = true
      @options.split = 1
      @options.sequence = ''
      @options.exclude = ''
      @options.use_debug_ids = false

      ENV.delete('XUMLIDOT_DEBUG')

      opt_parser = OptionParser.new do |opts|
        opts.banner = 'Usage: xumlidot.rb [options]'

        opts.separator ''
        opts.separator 'Specific options:'

        opts.on('-t', '--title [TEXT]', 'Title for the diagram') do |v|
          @options.title = v
        end

        opts.on('-m', '--model [TEXT]', 'Model Name for the diagram') do |v|
          @options.model_name = v
        end

        opts.on('-d', '--dot', 'Output diagram using dot (default)') do
          @options.diagram_type = :dot
        end

        opts.on('-x', '--xmi', 'Output diagram using xmi') do
          @options.diagram_type = :xmi
        end

        opts.on('-d', '--debug', 'Output debug information') do
          @options.debug = true
          ENV['XUMLIDOT_DEBUG'] = '1'
        end

        opts.on('-i', '--no-inheritance', 'Output inheritence links on the diagram') do
          @options.inheritance = false
        end

        opts.on('-c', '--no-composition', 'Output composition links on the diagram') do
          @options.composition = false
        end

        opts.on('-r', '--rails', 'Expect a Rails application') do |v|
          @options.rails = v
        end

        opts.on('-e', '--exclude [TEXT]', 'Exclude directories or files by pattern') do |v|
          @options.exclude = v
        end

        opts.on('-u', '--[no-]usage', 'Output usage links on the diagram') do |v|
          @options.usage = v
        end

        opts.on('-b', '--debug-ids', 'Output from a static list of ids') do |v|
          @options.use_debug_ids = v
        end

        opts.separator ''
        opts.separator 'Common options:'

        # No argument, shows at tail.  This will print an options summary.
        # Try it and see!
        opts.on_tail('-h', '--help', 'Show this message') do
          puts opts
          exit
        end

        # Another typical switch to print the version.
        opts.on_tail('--version', 'Show version') do
          puts ::Version.join('.')
          exit
        end
      end

      opt_parser.parse!(args)

      # Rather than pass the options around everywhere, lets set it as a class instance var
      # TODO: Remove code passing it around everywhere
      ::Xumlidot::Options.options = @options

      @options
    end
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/AbcSize
  end
end
