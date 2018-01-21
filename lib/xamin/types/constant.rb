require_relative '../xmi'

module Xamin
  module Types

    # Container class
    #
    # I'm thinking a hash to make lookup quicker but
    # an array may work just as well
    class Constants < Array

      # return exact matches
      def find_first(constant)
        found = find do |klass|
          klass.definition == constant.definition
        end
        return found unless found.nil?

        each do |_k|
          _k.constants.each do |klass|
             found = klass.constants.find_first(constant)
             return found unless found.nil?
          end
        end
        nil
      end

      # find any constant that is the root of the namespace for
      # the supplied constant
      def root_namespace_for(constant)
        found = find do |klass|
          klass.definition.root_namespace_for?(constant)
        end

        return found unless found.nil?

        each do |_k|
          _k.constants.each do |klass|
            return klass if klass.definition.root_namespace_for?(constant)
            found = klass.constants.root_namespace_for(constant)
            return found unless found.nil?
          end
        end
        nil
      end

      def to_xmi

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
        @namespace = namespace ? namespace.dup : []
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
