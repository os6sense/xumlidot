require_relative '../xmi'

module Xamin
  module Types
    # representation for class information
    #
    class Klass
      include ::Xamin::Xmi::Klass

      attr_accessor :definition,
                    :instance_methods,
                    :class_methods

      def initialize(definition)
        @definition = definition
        @instance_methods = []
        @class_methods = []
      end

      def to_s
        "#{definition} "
      end

      def add_method(m)
        m = m.definition if m.respond_to?(:definition)

        if m.superclass_method == true
          @class_methods << m
        else
          @instance_methods << m
        end
      end
    end
  end
end
