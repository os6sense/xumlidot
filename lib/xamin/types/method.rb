module Xamin
  module Types
    # Container class
    class Methods < Array
      def to_s
        each.map(&:to_s).join(', ')
      end
    end

    # Value object for a method
    #
    # we store all the method details here including many
    # which we are not yet using.
    class Method
      attr_accessor :name,               # string
                    :args,               # Argument
                    :file,               # string
                    :line_number,        # int  - these are areally a range
                    :line_max,
                    :visibility,         # symbol - :public, :private, or :protected
                    :superclass_method   # true or false

      def to_s
        @name = @name.is_a?(Regexp) ? @name.inspect : @name.to_s

        "#{visibility_symbol} #{@name}(#{@args})"
      end

      def visibility_symbol
        case @visibility
        when :public
          '+'
        when :private
          '-'
        when :protected
          '|'
        end
      end
    end
  end
end
