# frozen_string_literal: true

require 'forwardable'

require_relative '../types'

module Xumlidot
  module Types
    # representation for a class
    class Klass
      # Definition currently holds the superclass ... may change these to nesting and
      # ancestors yet...
      attr_accessor :definition,
                    # we *could* just have a single methods type
                    # and construct the instance/class list dynamically...
                    :attributes,
                    :instance_methods,
                    :class_methods,
                    # New additions as I attempt to resolve ancestry

                    # Okay so lets say we keep in constants all constants,
                    # modules and clasess (to make it easy to iterate over everything)
                    # are there any drawbacks ... well, well have to test each ...
                    # lets go with it
                    #
                    # Technically (for our purposes) a class, a module, and a constant are
                    # the same thing apart from being semantically different so the constants
                    # within a module or class with hold actual constants such as FOO = 1,
                    # but also Modules and Klasses
                    :constants,
                    :calls # Not yet implemented

      extend Forwardable
      def_delegator :@definition, :superklass, :superklass

      def initialize(definition)
        @definition = definition

        @instance_methods = InstanceMethods.new
        @class_methods = KlassMethods.new
        @attributes = Attributes.new
        @constants = Constants.new
      end

      def to_s
        "#{definition} "
      end

      def add_method(method_name)
        method_name = method_name.definition if method_name.respond_to?(:definition)

        if method_name.superclass_method == true
          @class_methods << method_name
        else
          @instance_methods << method_name
        end
      end
    end
  end
end
