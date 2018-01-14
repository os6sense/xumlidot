require 'sexp_processor'
require 'pry'

require_relative '../types'

module Xamin
  module Parsers
    # Parser for the KLASS DEFINITION ONLY and the name
    # probably should be changed to reflect that
    #
    # The main parser will handle method,
    # constants, etc
    #
    class ModuleDefinition < MethodBasedSexpProcessor

      attr_reader :definition

      def initialize(exp, namespace = nil)
        super()

        @definition = ::Xamin::Types::ModuleDefinition.new
        @definition.namespace = namespace

        process(exp)
      end

      def process_module(exp)
        exp.shift # remove :module
        definition = exp.shift

        # Processes the name of the module
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
          #if we have a symbol we have the actual module name
          # e.g. module Foo; end
          @definition.name << ::Xamin::Types::Constant.new(definition, @definition.namespace)
        end
        s()
      end
    end
  end
end
