# frozen_string_literal: true

require_relative '../types'

module Xumlidot
  module Types
    # Container class
    class MethodSignatures < Array
      def to_s
        each.map(&:to_s).join(', ')
      end
    end

    # Value object for a method
    #
    # we store all the method details here including many
    # which we are not yet using.
    class MethodSignature
      attr_accessor :name,               # symbol
                    :args,               # Arguments
                    :file,               # string
                    :line_number,        # int  - these are areally a range
                    :line_max,
                    :visibility,         # symbol - :public, :private, or :protected
                    :superclass_method   # true or false

      def initialize
        @superclass_method = false
      end

      def to_s
        "#{klass} #{visibility_symbol} #{clean_name}(#{@args})"
      end

      private

      def clean_name
        @name.is_a?(Regexp) ? @name.inspect : @name.to_s
      end

      def visibility_symbol
        case @visibility
        when :public
          '+'
        when :private
          '-'
        when :protected
          '#'
        end
      end

      def klass
        @superclass_method ? 'S' : 'I'
      end
    end
  end
end
