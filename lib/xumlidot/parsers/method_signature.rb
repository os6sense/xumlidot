# frozen_string_literal: true

require_relative '../parsers'
require_relative '../types'

module Xumlidot
  module Parsers
    # Parser for the arguments to a method
    #
    # e.g. formats def method(a, b = nil)
    #      to a string 'a, b = nil'
    #
    class MethodSignature < MethodBasedSexpProcessor
      # class Assignments < Hash
      # end

      attr_reader :definition

      def initialize(exp, superclass_method: false)
        super()

        @definition = ::Xumlidot::Types::MethodSignature.new
        @definition.visibility = Scope.get_visibility
        @definition.args = Args.new(exp.dup[0..2]).definition # only pass the method definition into args
        @definition.superclass_method = superclass_method

        # @assignments = Assignments.new

        process(exp)
      end

      def to_s
        @definition.to_s
      end

      # rubocop:disable Metrics/AbcSize
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
      rescue StandardError => e
        warn " ** bug: unable to proces defn #{exp}"

        sdebug('MethodSignature#process_defn', e)
      end
      # rubocop:enable Metrics/AbcSize

      def process_defs(exp)
        process_defn(exp)
      end

      # CALLS
      # TODO: We need a seperate assignment class to parse these
      # especially assignments so that we can attempt to work out types
      def process_call(exp)
        exp.shift # remove the :call

        _recv = process(exp.shift) # recv
        _name = exp.shift
        _args = process(exp.shift) # args

        exp
      rescue StandardError => e
        sdebug('MethodSignature#process_call', e)
        exp
      end

      def process_lasgn(exp)
        exp.shift # remove :lasgn

        _name = exp.shift.to_s
        value = exp.shift

        # @assignments[name] = value

        process(value)
        s()
      end

      private

      def sdebug(name, error)
        return s() unless ENV['XUMLIDOT_DEBUG']

        warn error.backtrace.reverse
        warn "ERROR (#{name}) #{error.message}"
        s()
      end
    end
  end
end
