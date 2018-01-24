# frozen_string_literal: true

require_relative '../types'

module Xumlidot
  module Types
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
        return 'r/w' if @read == true && @write == true
        return 'ro' if @read == true && @write == false
        return 'wo' if @read == false && @write == true
      end
    end
  end
end
