require 'sexp_processor'
require 'ruby_parser'
require 'pry'

require_relative '../types'
require_relative '../parsers'

module Xamin
  module Parsers
    # THE HARD PARTS
    #
    # FOR CLASS DIAGRAM
    # - Inheritance is ignored need to parse and attach (for the graph)
    #
    # - need to keep a track of the types of variables to that we know
    #   what the receivers class is i.e. uses.
    #
    # - need to identify if methods are public/private/protected: DONE
    # - Parse arguments: DONE (partially - a few edge cases remain)

    # TODO - change the inheritance type; we should aim to inherit
    #        from a lower level parser since we are not using everything
    #        from the MethodBasedSexpProcessor
    #
    # Takes a file contents (as a string) and parses it into
    # s expressions using ruby parser. The parse method uses
    # the SexpProcessors methods to contert to a graph
    class File < MethodBasedSexpProcessor

      def initialize(file_contents)
        @parsed_file = RubyParser.new.parse(file_contents)
        @km_stack = [Xamin::Types::Klass.new(nil)]
        super()
      end

      def parse(graph = nil)
        @graph = graph
        process(@parsed_file)
      end

      # CLASS AND MODULE DEFINITIONS
      #
      # We process the superclass differently since we dont want an
      # actual superclass node adding - just the methods
      def process_sclass(exp)
        super(exp) do
          # save current visibility and restore it after processing
          temp_visibility = get_visibility
          set_visibility
          process_until_empty(exp)
          set_visibility(temp_visibility)
        end
      rescue Exception => e
        puts "ERROR (#process_sclass) #{e.message}"
        exp
      end

      def process_module(exp)
        process_class(exp, ::Xamin::Parsers::ModuleDefinition, Xamin::Types::Module)
      end

      def process_class(exp, definition_klass = ::Xamin::Parsers::KlassDefinition, definition_type = Xamin::Types::Klass)
        set_visibility
        definition = definition_klass.new(exp.dup[0..2], @class_stack).definition
        puts definition.to_s
        super(exp) do
          temp_visibility = get_visibility
          @km_stack << definition_type.new(definition)
          @graph.add_class(@km_stack.last)
          process_until_empty(exp)
          @km_stack.pop
          set_visibility(temp_visibility)
        end
      rescue Exception => e
        puts "ERROR (#process_class) #{e.message}"
        exp
      end

      # METHOD SIGNATURES
      def process_defn(exp, superclass_method = false)
        method = ::Xamin::Parsers::MethodSignature.new(exp, superclass_method || @sclass.last)
        @km_stack.last.add_method(method)
        puts method.to_s
        super(exp) { process_until_empty(exp) }
      rescue Exception => e
        puts "ERROR (#process_def#{superclass_method ? 's' : 'n'}) #{e.message}"
        puts e.backtrace.reverse
        exp
      end

      def process_defs(exp)
        process_defn(exp, true)
      end

      # CALLS
      def process_call(exp)
        exp.shift # remove the :call

        recv = process(exp.shift) # recv
        name = exp.shift
        args = process(exp.shift) # args

        case name
        when :private, :public, :protected
          set_visibility(name)
        when :include
          binding.pry
        when :extend
          binding.pry
        else
          #puts "CALL RECV:#{recv unless recv.nil? || recv.empty?} NAME:#{name} ARGS:#{args unless args.nil? || args.empty?}"
        end
        return exp
      rescue Exception => e
        puts "ERROR (#process_call) #{e.message}"
        exp
      end

      # PRIVATE
      def set_visibility(state = :public)
        ::Xamin::Parsers::MethodSignature::Visibility.send(state)
      end

      def get_visibility
        ::Xamin::Parsers::MethodSignature::Visibility.state
      end
    end
  end
end
