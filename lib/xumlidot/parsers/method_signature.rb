require 'sexp_processor'
require 'pry'

require_relative '../types'
require_relative '../parsers'

module Xumlidot
  module Parsers
    # Parser for the arguments to a method
    #
    # e.g. formats def method(a, b = nil)
    #      to a string 'a, b = nil'
    #
    class MethodSignature < MethodBasedSexpProcessor

      # Container for values assigned to a variable
      #class Assignments < Hash
      #end

      attr_reader :definition

      def initialize(exp, superclass_method = false)
        super()

        @definition = ::Xumlidot::Types::MethodSignature.new
        @definition.visibility = Scope.get_visibility
        @definition.args = Args.new(exp.dup[0..2]).definition # only pass the method definition into args
        @definition.superclass_method = superclass_method

        #@assignments = Assignments.new

        process(exp)
      end

      def to_s
        @definition.to_s
      end

      def process_defn(exp)
        exp.shift unless auto_shift_type # node type
        exp.shift if exp.first.is_a?(Sexp) && exp.first.value == :self # remove :self

        @definition.name = exp.shift
        @definition.file = exp.file
        @definition.line_number = exp.line
        @definition.line_max = exp.line_max

        more = exp.shift
        process(more) if more.is_a?(Sexp) && !more.empty?
        s()
      rescue Exception => e
        STDERR.puts "ERROR (MethodSignature#process_defn) #{e.message}" 
        STDERR.puts e.backtrace.reverse
        s()
      end

      def process_defs(exp)
        process_defn(exp)
      end

      # CALLS
      # TODO: We need a seperate assignment class to parse these
      # especially assignments so that we can attempt to work out types
      def process_call(exp)
        exp.shift # remove the :call

        recv = process(exp.shift) # recv
        name = exp.shift
        args = process(exp.shift) # args

        exp
      rescue Exception => e
        STDERR.puts "ERROR (MethodSignature#process_call) #{e.message}" 
        STDERR.puts e.backtrace.reverse
        exp
      end

      def process_lasgn(exp)
        exp.shift # remove :lasgn

        name = exp.shift.to_s
        value = exp.shift

        #@assignments[name] = value

        process(value)
        s()
      end
    end
  end
end
