module Xamin
  module Types
    # representation for module information
    # Note - can probably just inheit from Klass
    class ModuleDefinition
      attr_accessor :name,
                    :namespace,
                    :superklass

      def initialize
        @name = []
        @superklass = []
      end

      def to_s
        "MODULE: #{@name.first}"
      end
    end
  end
end
