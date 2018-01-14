require 'sexp_processor'
require 'pry'

require_relative '../types'

module Xamin
  module Parsers

    # Parser for the KLASS DEFINITION ONLY and the name
    # probably should be changed to reflect that
    #
    class KlassDefinition < MethodBasedSexpProcessor

      attr_reader :definition

      def initialize(exp, namespace = nil)
        super()

        @definition = ::Xamin::Types::KlassDefinition.new
        @definition.namespace = namespace

        process(exp)
      end

      def process_class(exp)
        exp.shift # remove :class
        definition = exp.shift

        # Processes the name of the class
        if Sexp === definition
          case definition.sexp_type
          when :colon2 then # Reached in the event that a name is a compound
            name = definition.flatten
            name.delete :const
            name.delete :colon2
            name.each do |v|
              @definition.name << ::Xamin::Types::Constant.new(v, @definition.namespace)
            end
          when :colon3 then # Reached in the event that a name begins with ::
            @definition.name << ::Xamin::Types::Constant.new(definition.last, '::')
          else
            raise "unknown type #{exp.inspect}"
          end
        else Symbol === definition
          #if we have a symbol we have the actual class name
          # e.g. class Foo; end
          @definition.name << ::Xamin::Types::Constant.new(definition, @definition.namespace)
        end

        # Processess inheritance
        process_until_empty(exp)

        s()
      end

      def process_const(exp)
        @definition.superklass << exp.value.to_s
        process_until_empty(exp)
        s()
      end

      def process_colon2(exp)
        exp.shift # remove :colon2
        @definition.superklass << exp.value.to_s
        process_until_empty(exp)
        s()
      end

      def process_colon3(exp)
        exp.shift # remove :colon3
        @definition.superklass << "::#{exp.value}"
        process_until_empty(exp)
        s()
      end
    end
  end
end
