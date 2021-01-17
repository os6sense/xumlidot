# frozen_string_literal: true

module Xumlidot
  # This is code that was living in bin/xumlidot. We need to leverage
  # it for running integration tests though
  class Loader
    def initialize(directories, options)
      @directories = directories
      @options = options
    end

    def load
      dt = Xumlidot::DirectoryTree.new(directories, options)

      # This is our tree of klasses/modules etc
      # since we can't assume rails conventions for naming
      # in a Ruby program.
      constants = ::Xumlidot::Parsers::Stack::Constants.new

      # TODO: move into directory tree
      dt.find_all_rb_files do |path|
        warn path if ::Xumlidot::Options.debug == true
        file_contents = File.read(path)

        @parser = Xumlidot::Parsers::File.new(file_contents, constants)
        @parser.parse
      end

      # If a class is inherited from but does not exist in the constants
      # we will create a dummy class.
      #
      # if a class is inherited from, we want to find it using the constant lookup
      # rules definind in the resolver
      #
      # and what ... we want to add a reference too it?
      #
      # This REALLY should be done whenever we add a superklass
      # i.e. yeah, its a hack
      constants.resolve_inheritance

      diagram = ::Xumlidot::Diagram.new(constants, options)
      diagram.draw
    end

    private

    attr_accessor :directories, :options
  end
end
