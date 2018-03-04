# frozen_string_literal: true

require_relative '../types'

module Xumlidot
  module Types
    class InheritedModule < Superklass
      attr_reader :type

      def initialize(name, namespace = nil)
        super
        @has_root = false
        @type = nil
      end

      def type=(value)
        case value
        when :extend, :prepend, :include
          @type = value
        end
      end
    end
  end
end
