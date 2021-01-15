# frozen_string_literal: true

require_relative '../parsers'
require_relative '../types'

module Xumlidot
  module Parsers
    module Stack
      class Constants
        attr_reader :last_added

        def initialize
          # This should be main or object
          @nesting = Xumlidot::Types::Klass.new(nil)
          @last_added = @nesting
        end

        def traverse(&block)
          @nesting.constants.traverse(&block)
        end

        # when we add a constant we might want to add to the top of the tree
        # e.g.
        # Module A
        # Moudle B
        #
        # or we might want to add onto a given const
        # e,g
        # Module A
        #   Module B
        #
        # add(Module C, Module B)
        #
        def add(c)
          return if @nesting.constants.find_first(c)

          root = @nesting.constants.root_namespace_for(c)
          (root.nil? ? @nesting.constants : root.constants) << c
          @last_added = c
        end

        class ExternalKlassReferences < Array
          def <<(external_klass)
            return if find do |klass|
              klass.definition == external_klass.definition
            end

            super(external_klass)
          end
        end

        def resolve_inheritance(_constant = nil)
          external_klasses = ExternalKlassReferences.new

          # The first traversal we are going through finding all
          # classes with a superklass. The second traversal we are
          # trying to find the klass which is the superklass of the superklass
          # found in the first traversal.
          #
          # Note Im hacking through this so poor code
          @nesting.constants.traverse do |klass|
            next if klass.definition.superklass.empty?

            # If we reach here we have a superklass
            @nesting.constants.traverse do |other_klass|
              if other_klass.definition.superklass_of?(klass.definition.superklass)
                warn "SETTING SUPERKLASS REFERENCE FOR #{klass} to #{other_klass}" if ::Xumlidot::Options.debug == true
                klass.superklass.reference = other_klass
                break
              end
            end

            if klass.superklass.reference.nil?
              # See if we have added it already to the list of external_klasses
              found = external_klasses.find do |external_klass|
                klass.definition == external_klass.definition
              end

              if found
                klass.superklass.reference = found
              else
                new_klass = klass.definition.superklass.to_klass
                klass.superklass.reference = new_klass
                external_klasses << new_klass

                add(new_klass)
              end
            end
          end
        end
      end
    end
  end
end
