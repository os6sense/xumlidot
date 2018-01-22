# frozen_string_literal: true

require_relative '../types'

module Xamin
  module Types

    # Our representation of a constant - although just
    # a string we need to be able to be unabigous in
    # our representation.
    class Constant
      attr_reader :name,
                  :namespace

      attr_accessor :reference # TODO: Namespace so needs to
                               #       be a class

      def initialize(name, namespace = nil)
        @name = name
        @namespace = namespace ? namespace.dup : []
      end

      def to_s
        "#{@name} (#{formatted_namespace})"
      end

      def to_xmi
        "#{formatted_namespace}::#{@name}"
      end

      def empty?
        @name.nil? && @namespace == []
      end

      private

      def root
        return '::' if @namespace.empty?
      end

      def formatted_namespace
        [@namespace].flatten.reverse.each(&:to_s).join('::')
      end
    end
  end
end
