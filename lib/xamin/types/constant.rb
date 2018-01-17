require_relative '../xmi'

module Xamin
  module Types

    # Container class
    #
    # I'm thinking a hash to make lookup quicker but 
    # an array may work just as well
    class Constants < Hash

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
