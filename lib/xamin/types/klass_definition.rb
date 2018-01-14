module Xamin
  module Types
    # representation for class information
    #
    class KlassDefinition
      attr_accessor :name,
                    :namespace,
                    :superklass

      def initialize
        @name = []
        @superklass = []
      end

      def to_s
        "KLASS: #{name.first} < #{@superklass.reverse} "
      end
    end
  end
end
