require 'sexp_processor'
require 'pry'

module Xamin
  module Parsers
    # Parser for arguments to a method
    class Args < MethodBasedSexpProcessor
      def initialize(exp)
        super()

        @exp = exp
        @arguments = []
      end

      def to_s
        process(@exp)
        @arguments
      end

      def process_nil(exp)
        @argument_default = 'NIL'
        s()
      end

      def process_str(exp)
        @argument_default = exp.value
        s()
      end

      def process_hash(exp)
        @argument_default = {}
        s()
      end

      def process_array(exp)
        @argument_default = []

        exp.shift # :array
        exp.each { |element| process(element) }
        s()
      end

      def process_lasgn(exp)
        lasgn = exp.shift
        name = exp.shift
        value = exp.shift

        @argument_name = name
        process(value)
        s()
      end

      def process_lit(exp)
        exp.shift # :lit

        case @argument_default
        when Array
          @argument_default << exp.value
        when nil
          @argument_default = nil
        when hash
          binding.pry
        else
          binding.pry
        end
        s()
      end

      def process_kwarg(exp)
        lit = exp.shift
        @argument_name = exp[0]
        binding.pry
        process(exp)
        s()
      end

      def process_args(exp)
        args = exp.shift
        exp.each do |arg|
          @argument_name = nil
          @argument_default =  nil
          if arg.is_a? Sexp
            process(arg)
          else
            @argument_name = arg
          end

          @arguments << [@argument_name, @argument_default]
        end
      end
    end
  end
end
