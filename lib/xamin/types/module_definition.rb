# frozen_string_literal: true

require_relative '../types'

module Xamin
  module Types
    # Contains information as to how the module was defined.
    class ModuleDefinition < KlassDefinition
      def to_s
        "MODULE: #{@name.first}"
      end
    end
  end
end
