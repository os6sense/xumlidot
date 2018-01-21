require 'sexp_processor'
require 'ruby_parser'
require 'pry'

require_relative '../types'
require_relative '../parsers'

module Xamin
  module Parsers

    # PRIVATE
    #
    # Save current visibility and restore it after processing
    #
    module Scope
      def public(&block)
        temp_visibility = get_visibility
        set_visibility
        yield if block_given?
        set_visibility(temp_visibility)
      end
      module_function :public

      def set_visibility(state = :public)
        ::Xamin::Parsers::MethodSignature::Visibility.send(state)
      end
      module_function :set_visibility

      def get_visibility
        ::Xamin::Parsers::MethodSignature::Visibility.state
      end
      module_function :get_visibility
    end

    # We are treating modules, classes and constants the same in terms of how
    # they are defined so this constant stack will contain all three.
    #

    module Stack
      class Constants
        attr_reader :last_added

        def initialize
          # This should be main or object
          @nesting = Xamin::Types::Klass.new(nil)
          @last_added = @nesting
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

          namespace_root = @nesting.constants.root_namespace_for(c)

          if namespace_root.nil?
            @nesting.constants <<  c
          else
            namespace_root.constants << c
          end

          @last_added = c
        end
      end
    end

    # Formerly File
    #
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
      rescue Exception => e
        STDERR.puts "ERROR (#process_sclass) #{e.message}"
        exp
      end

      def process_module(exp)
        process_class(exp,
                      definition_parser: ::Xamin::Parsers::ModuleDefinition,
                      type: Xamin::Types::Module)
      end

      def process_class(exp,
                        definition_parser: ::Xamin::Parsers::KlassDefinition,
                        type: Xamin::Types::Klass)

        Scope.set_visibility
        definition = definition_parser.new(exp.dup[0..2], @class_stack).definition

        STDERR.puts definition.to_s
        super(exp) do
          Scope.public do
            klass_or_module = type.new(definition)
            @constants.add(klass_or_module)
            process_until_empty(exp)
          end
        end
      rescue Exception => e
        STDERR.puts "ERROR (#process_class) #{e.message}"
        STDERR.puts e.backtrace.reverse
        exp
      end

      # METHODS & METHOD SIGNATURES
      def process_defn(exp, superclass_method = false)
        method = ::Xamin::Parsers::MethodSignature.new(exp, superclass_method || @sclass.last)
        @constants.last_added.add_method(method)
        STDERR.puts method.to_s
        #super(exp) { process_until_empty(exp) } # DISABLING since parsing the method is crashing
        s()
      rescue Exception => e
        STDERR.puts "ERROR (#process_def#{superclass_method ? 's' : 'n'}) #{e.message}"
        s()
      end

      def process_defs(exp)
        process_defn(exp, true)
      end

      # CALLS
      def process_call(exp)
        ::Xamin::Parsers::Call.new(exp, @constants.last_added)
        s()
      rescue Exception => e
        STDERR.puts "ERROR (#process_call) #{e.message}"
        s()
      end

    end
  end
end
