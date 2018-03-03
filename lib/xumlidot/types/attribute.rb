# frozen_string_literal: true

require_relative '../types'

module Xumlidot
  module Types
    # Value object for an attribute, i.e. accessor defined
    # via attr_reader, attr_writer or attribute
    #
    class Attribute
      attr_accessor :read,
                    :write,
                    :name

      def initialize(name, read, write)
        @name = name.to_s
        @read = read
        @write = write
      end

      def to_s
        "(#{accessibility}) #{@name}"
      end

      private

      def accessibility
        return 'r+w' if @read && @write
        return 'ro' if @read && !@write
        return 'wo' if !@read && @write
      end
    end
  end
end
