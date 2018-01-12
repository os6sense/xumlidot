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

      def initialize(exp)
        super()

        @method = ::Xamin::Types::Method.new
        @method.visibility = Visibility.state
        @method.args = Args.new(exp.dup)

        process(exp.dup)
      end

      def to_s
        @method.to_s
      end

      def process_defn(exp)
        exp.shift unless auto_shift_type # node type
        @method.name = exp.shift 
        @method.file = exp.file
        @method.line_number = exp.line
        @method.line_max = exp.line_max
        process_until_empty(exp)
        s()
      end

      ##
      # Process a singleton method node until empty. Tracks your location.
      # If you have to subclass and override this method, you can clall
      # super with a block.

      def process_defs(exp)
        process_defn(exp)
      end
    end
  end
end
