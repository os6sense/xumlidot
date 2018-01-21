require_relative '../xmi'

module Xamin
  module Types

    # Container class
    #
    # I'm thinking a hash to make lookup quicker ...
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

      def traverse(&block)
        each do |_k|
          yield _k if block_given?
          _k.constants.each do |klass|
            yield klass if block_given?
            klass.constants.traverse(&block)
          end
        end
      end

      def to_xmi

      end
    end


