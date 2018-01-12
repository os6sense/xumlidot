module Xamin
  module Types
    # Container class
    class Arguments < Array
      def to_s
        each.map(&:to_s).join(',')
      end
    end

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
    class Argument
      attr_accessor :name, :assign, :default

      def to_s
        [name, assign, default ? default.to_s : nil ].compact.join(' ')
      end
    end
  end
end
