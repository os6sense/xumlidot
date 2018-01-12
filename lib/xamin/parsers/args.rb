require 'sexp_processor'
require 'pry'

require_relative '../types'

module Xamin
  module Parsers
    # Parser for the arguments to a method
    #
    # e.g. formats def method(a, b = nil)
    #      to a string 'a, b = nil'
    #
    class Args < MethodBasedSexpProcessor

      def initialize(exp)
        super()

        @exp = exp
        @arguments = ::Xamin::Types::Arguments.new
      end

      def to_s
        process(@exp)
        @arguments.to_s
      end

      def process_nil(exp)
        @argument.default = 'nil'
        s()
      end

      def process_str(exp)
        @argument.default = exp.value
        s()
      end

      def process_hash(exp)
        @argument.default = {}
        s()
      end

      def process_array(exp)
        @argument.default = []

        exp.shift # remove :array
        exp.each { |element| process(element) }
        s()
      end

      def process_lasgn(exp)
        exp.shift # remove :lasgn

        @argument.name = exp.shift.to_s
        value = exp.shift

        process(value)
        s()
      end

      def process_lit(exp)
        exp.shift # remove :lit

        case @argument.default
        when Array
          @argument.default << exp.value
        when nil
          @argument.default = exp.value
        when Sexp
          binding.pry
        when hash
          binding.pry
        else
          binding.pry
        end
        s()
      end

      def process_kwarg(exp)
        exp.shift # remove :kwarg
        @argument.name = "#{exp[0]}:"
        process(exp)
        s()
      end

      def process_args(exp)
        exp.shift # remove :args
        exp.each do |arg|
          @argument = ::Xamin::Types::Argument.new
          if arg.is_a? Sexp
            @argument.assign = '='
            process(arg)
          else
            @argument.name = arg.to_s
          end

          @arguments << @argument
        end
      end
    end
  end
end
