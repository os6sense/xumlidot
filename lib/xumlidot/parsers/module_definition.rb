# frozen_string_literal: true

require_relative '../parsers'
require_relative '../types'

module Xumlidot
  module Parsers
    # Parser for the KLASS DEFINITION ONLY and the name
    # probably should be changed to reflect that
    #
    # The main parser will handle method,
    # constants, etc
    class ModuleDefinition < MethodBasedSexpProcessor
      attr_reader :definition

      def initialize(exp, namespace = nil)
        super()

        @definition = ::Xumlidot::Types::ModuleDefinition.new
        @namespace = namespace.dup

        process(exp)
      end

      # rubocop:disable Metrics/AbcSize
      def process_module(exp)
        exp.shift # remove :module
        definition = exp.shift

        # Processes the name of the module
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
        # FIXME: bug - fix when we've added specs
        else # Symbol === definition
          # if we have a symbol we have the actual module name e.g. module Foo; end
          @definition.name << ::Xumlidot::Types::Constant.new(definition, @namespace)
        end
        s()
      end
      # rubocop:enable Metrics/AbcSize
    end
  end
end
