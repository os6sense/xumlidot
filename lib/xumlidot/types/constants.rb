# frozen_string_literal: true

require_relative '../types'

module Xumlidot
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

        each do |k|
          k.constants.each do |klass|
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

        each do |k|
          k.constants.each do |klass|
            return klass if klass.definition.root_namespace_for?(constant)

            found = klass.constants.root_namespace_for(constant)
            return found unless found.nil?
          end
        end
        nil
      end

      def traverse(&block)
        each do |k|
          yield k if block_given?
          k.constants.each do |klass|
            yield klass if block_given?
            klass.constants.traverse(&block)
          end
        end
      end
    end
  end
end
