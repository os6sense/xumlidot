# frozen_string_literal: true

require_relative '../types'

module Xumlidot
  module Types
    # Our representation of a constant - although just
    # a string we need to be able to be unambigous in
    # the representation.
    #
    # name is a single constant, namespace is the remaining full path
    #
    # e.g
    # For ::Xumlidot::Types::Constant the name would be Constant and the
    # namespace [Types, Xumlidot]
    #
    # Note I am REALLY unhappy with this design ...
    class Constant
      attr_reader :name,
                  :namespace

      # TODO: Appears unused, remove when specs complete
      attr_accessor :reference # I think I may have thrown this in to fix a traversal issue if so...hack!

      def initialize(name, namespace = nil)
        @name = name
        @namespace = namespace ? namespace.dup : []
      end

      def to_s
        "#{@name} (#{formatted_namespace})"
      end

      def empty?
        @name.nil? && @namespace.empty?
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
