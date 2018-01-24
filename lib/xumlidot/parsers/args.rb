require 'sexp_processor'
require 'pry'

require_relative '../types'

module Xumlidot
  module Parsers
    # Parser for the arguments to a method
    #
    # e.g. formats def method(a, b = nil)
    #      to a string 'a, b = nil'
    #
    class Args < MethodBasedSexpProcessor

      def initialize(exp)
        super()

        @arguments = ::Xumlidot::Types::Arguments.new

        process(exp)
      end

      def to_s
        @arguments.to_s
      end

      def definition
        @arguments
      end

      # Note - special case since a value of nil for default
      # means we shouldn't display it and so we use the :nil
      # symbol to represent an *actual assignment of nil* to
      # a variable.
      def process_nil(exp)
        @argument.default = :nil
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

      # const means that we have a constant assignment such as (a = Foo)
      def process_const(exp)
        @argument.default = exp.value
        s()
      end

      # Colon2 means that we have a constant assignment such as (a = Foo::Bar)
      def process_colon2(exp)
        name = exp.flatten
        name.delete :const
        name.delete :colon2

        # I'm not sure how best to proceed here.
        #
        # I can use const_set to start creating the constants heirachy
        # but this is complex since it needs to be inserted into the right
        # place and for that I need the namespace...which suggests this ISNT
        # the place to do that. I possibly need a fake class ...
        @argument.default = name.map { |v| v.to_s }.to_a.join('::')
        s()
      end

      # Colon2 means that we have a constant assignment such as (a = ::Foo::Bar)
      # again see the note in colon2 about how to proceed
      def process_colon3(exp)
        process_colon2(exp)
        @argument.default = "::#{argument.default}"
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
        when hash # WTF? TODO
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
          @argument = ::Xumlidot::Types::Argument.new
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
