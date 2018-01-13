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
    class Methods < MethodBasedSexpProcessor

      # Maintains current state of method visability
      class Visibility
        class << self

          def state
            @state ||= :public
          end

          def public
            @state = :public
          end

          def protected
            @state = :protected
          end

          def private
            @state = :private
          end
        end
      end

      class Assignments < Hash
      end

      def initialize(exp, superclass_method: false)
        super()

        @method = ::Xamin::Types::Method.new
        @method.visibility = Visibility.state
        @method.args = Args.new(exp.dup[0..2]) # only pass the method definition into args
        @method.superclass_method = superclass_method

        @assignments = Assignments.new

        process(exp)
      end

      def to_s
        @method.to_s
      end

      def to_method
        @method
      end

      def process_defn(exp)
        exp.shift unless auto_shift_type # node type
        @method.name = exp.shift
        @method.file = exp.file
        @method.line_number = exp.line
        @method.line_max = exp.line_max

        more = exp.shift
        process(more) if more.is_a?(Sexp) && !more.empty?
        s()
      rescue Exception => e
        binding.pry
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
        puts "ERROR (#process_call) #{e.message}"
        exp
      end

      def process_lasgn(exp)
        exp.shift # remove :lasgn

        name = exp.shift.to_s
        value = exp.shift

        @assignments[name] = value

        process(value)
        s()
      end


    end
  end
end
