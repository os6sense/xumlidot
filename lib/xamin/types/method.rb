module Xamin
  module Types
    # Value object for the actual argument
    #
    # Depending on the argument type, assign and default
    # may be unpopulated e.g. 
    #
    #    def foo(a, b) 
    #
    # will be parsed with an empty assign and default
    #
    #    def bar(a, b = nil)
    #
    # will have an assign of '=' and a default of nil
    #
    # Note that in Args, an assignment to a variable of nil 
    # is parsed and the default value set to th symbol :nil
    class Method
      attr_accessor :name, :args, :file, :line_number, :line_max, :visibility

      def to_s
        @name = @name.is_a?(Regexp) ? @name.inspect : @name.to_s

        "#{@visibility} #{@name}(#{@args})"
      end
    end
  end
end
