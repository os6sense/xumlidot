# frozen_string_literal: true

require_relative '../parsers'
require_relative '../types'

module Xumlidot
  module Parsers
    # Parser for the KLASS DEFINITION ONLY
    class KlassDefinition < MethodBasedSexpProcessor
      attr_reader :definition

      def initialize(exp, namespace = nil)
        super()

        @definition = ::Xumlidot::Types::KlassDefinition.new
        @namespace = namespace.dup

        process(exp)
      end

      # rubocop:disable Metrics/AbcSize
      # rubocop:disable Metrics/MethodLength
      def process_class(exp)
        exp.shift # remove :class
        definition = exp.shift

        # Processes the name of the class
        if Sexp === definition # rubocop:disable Style/CaseEquality
          case definition.sexp_type
          when :colon2 # Reached in the event that a name is a compound
            name = definition.flatten
            name.delete :const
            name.delete :colon2
            name.each do |v|
              @definition.name << ::Xumlidot::Types::Constant.new(v, @namespace)
            end
          when :colon3 # Reached in the event that a name begins with ::
            @definition.name << ::Xumlidot::Types::Constant.new(definition.last, '::')
          else
            raise "unknown type #{exp.inspect}"
          end
        # TODO: looks like a bug - fix when we get specs
        else # Symbol === definition
          # if we have a symbol we have the actual class name e.g. class Foo; end
          @definition.name << ::Xumlidot::Types::Constant.new(definition, @namespace)
        end

        # Processess inheritance
        process_until_empty(exp)

        s()
      end
      # rubocop:enable Metrics/AbcSize
      # rubocop:enable Metrics/MethodLength

      def process_const(exp)
        # TODO: may have removed a shift by mistake
        @definition.superklass << exp.value
        process_until_empty(exp)
        s()
      end

      def process_colon2(exp)
        exp.shift # remove :colon2
        @definition.superklass << exp.value
        process_until_empty(exp)
        s()
      end

      def process_colon3(exp)
        exp.shift # remove :colon3
        @definition.superklass << '::'
        @definition.superklass << exp.value
        process_until_empty(exp)
        s()
      end
    end
  end
end
