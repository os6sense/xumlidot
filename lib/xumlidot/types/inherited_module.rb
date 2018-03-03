# frozen_string_literal: true

require_relative '../types'

module Xumlidot
  module Types
    class InheritedModule < Superklass
      def initialize(name, namespace = nil)
        super
        @has_root = false
        @extend = false
        @include = false
      end
    end
  end
end
