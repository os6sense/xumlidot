require_relative '../xmi'
require_relative 'constant'

module Xamin
  module Types

    class Superklass < ::Xamin::Types::Constant

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
    end

    class InheritedModule < Superklass
      def initialize(name, namespace = nil)
        super
        @has_root = false
        @extend = false
        @include = false
      end
    end


    # representation for class information
    class KlassDefinition

      # TODO: I think the name could be a constant rather than
      # an array of constants
      class Name < Array
        def to_xmi
          map do |constant|
            constant.to_xmi
          end.join
        end

        def name
          map(&:name).flatten
        end

        def namespace
          map(&:namespace).flatten
        end

        def ==(other)
          namespace == other.namespace &&
            name == other.name
        end
      end

      attr_accessor :name,
                    :superklass,
                    :inherited_modules

      def initialize
        @name = Name.new
        @superklass = Superklass.new(nil)
        @inherited_modules = []
      end

      def to_s
        "KLASS: #{@name.first} < #{@superklass} "
      end

      # No need to compare namespaces here since that is done in the
      # name
      def ==(other)
        @name == other.name
      end

      # Returns true or false depending on whether or not, given the
      # definition for the class, it can be considered the root namespace of
      # the other class.
      #
      #  This allows us to work out is this is a klass under which the other
      #  class should be nested in a class or module namespace heirarchy.
      def root_namespace_for?(other)
        #binding.pry if other.definition.name.name == [:V1]
        [@name.name, @name.namespace].flatten == other.definition.name.namespace
      end

    end
  end
end
