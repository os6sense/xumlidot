# frozen_string_literal: true

require_relative '../types'

module Xumlidot
  module Types
    class Superklass < ::Xumlidot::Types::Constant
      def initialize(name, namespace = nil)
        super
        @has_root = false
      end

      def <<(constant)
        if constant == '::'
          @has_root = true
          return
        end

        @namespace << constant unless @name.nil?
        @name ||= constant
      end

      # Create a klass from the superclass for adding
      # to the list of constants.
      def to_klass
        definition = KlassDefinition.new
        definition.name << ::Xumlidot::Types::Constant.new(@name, @namespace)
        Klass.new(definition)
      end
    end
  end
end
