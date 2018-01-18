require_relative '../xmi'
require_relative 'klass_definition'

module Xamin
  module Types
    class ModuleDefinition < KlassDefinition
      def to_s
        "MODULE: #{@name.first}"
      end
    end
  end
end
