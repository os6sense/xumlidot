require_relative '../xmi'
require_relative 'klass_definition'

module Xamin
  module Types
    # representation for module information
    # Note - can probably just inheit from Klass
    class ModuleDefinition < KlassDefinition
      attr_accessor :name,
                    :namespace,
                    :superklass

      def to_s
        "MODULE: #{@name.first}"
      end
    end
  end
end
