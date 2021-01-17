# frozen_string_literal: true

require_relative '../parsers'
require_relative '../types'

module Xumlidot
  module Parsers
    # We need a level of indirection between the actual parser
    # and MethodBasedSexpProcessor since we will probably end up inheriting
    # from SexpProcessor directly eventually
    #
    # The File processor was getting too busy and its obvious we want to share
    # some bits of the processing
    class Generic < MethodBasedSexpProcessor
      attr_reader :constants

      def initialize(string, constants = Stack::Constants.new)
        @parsed = RubyParser.new.parse(string)
        @constants = constants
        super()
      end

      def parse
        process(@parsed)
      end

      # CLASSES, MODULES AND DEFINITIONS
      #
      # We process the superclass differently since we dont want an
      # actual superclass node adding - just the methods
      def process_sclass(exp)
        super(exp) do
          Scope.public { process_until_empty(exp) } # Process the superclass with public visibility
        end
      rescue StandardError => e
        sdebug('#process_sclass', e)
        exp
      end

      def process_module(exp)
        process_class(exp,
                      definition_parser: ::Xumlidot::Parsers::ModuleDefinition,
                      type: Xumlidot::Types::Module)
      end

      def process_class(exp,
                        definition_parser: ::Xumlidot::Parsers::KlassDefinition,
                        type: Xumlidot::Types::Klass)

        Scope.set_visibility
        definition = definition_parser.new(exp.dup[0..2], @class_stack).definition

        warn definition.to_s if ::Xumlidot::Options.debug == true
        super(exp) do
          Scope.public do
            klass_or_module = type.new(definition)
            @constants.add(klass_or_module)
            process_until_empty(exp)
          end
        end
      rescue StandardError => e
        sdebug('#process_class', e)
        exp
      end

      # METHODS & METHOD SIGNATURES
      # rubocop:disable Style/OptionalBooleanParameter
      def process_defn(exp, superclass_method = false)
        method = ::Xumlidot::Parsers::MethodSignature.new(exp, superclass_method || @sclass.last)
        @constants.last_added.add_method(method)
        warn method.to_s if ::Xumlidot::Options.debug == true
        # super(exp) { process_until_empty(exp) } # DISABLING since parsing the method is crashing
        s()
      rescue StandardError => e
        sdebug("#process_def#{superclass_method ? 's' : 'n'}", e)
      end
      # rubocop:enable Style/OptionalBooleanParameter

      def process_defs(exp)
        process_defn(exp, true)
      end

      # CALLS
      def process_call(exp)
        ::Xumlidot::Parsers::Call.new(exp, @constants.last_added)
        s()
      rescue StandardError => e
        sdebug('#process_call', e)
      end

      def sdebug(name, error)
        return s() unless ENV['XUMLIDOT_DEBUG']

        warn error.backtrace.reverse
        warn "ERROR (#{name}) #{error.message}"
        s()
      end
    end
  end
end
