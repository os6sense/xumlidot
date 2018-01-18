require_relative '../xmi'

module Xamin
  module Types

    # Container class
    #
    # I'm thinking a hash to make lookup quicker but
    # an array may work just as well
    class Constants < Array
      def find(constant)
        each do |klass|
          # dont add the same modules twice
          if klass.definition.name == constant.definition.name &&
            klass.definition.name.to_namespace == constant.definition.name.to_namespace
            return nil
          end

          if klass.definition.name.to_namespace == constant.definition.namespace
            binding.pry
            return klass
          else
            binding.pry
          end
        end
        nil
      end
    end


    # Our representation of a constant - although just
    # a string we need to be able to be unabigous in
    # our representation.
    class Constant
      attr_reader :name,
                  :namespace

      def initialize(name, namespace = nil)
        @name = name
        @namespace = namespace.dup
      end

      def to_s
        "#{@name} (#{formatted_namespace})"
      end

      def to_xmi
        "#{formatted_namespace}::#{@name}"
      end

      private

      def root
        return '::' if @namespace.empty?
      end

      def formatted_namespace
        [@namespace].flatten.reverse.each(&:to_s).join('::')
      end
    end
  end
end
