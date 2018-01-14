module Xamin
  module Types
    # Our representation of a constant - although just
    # a string we need to be able to be unabigous in
    # our representation.
    class Constant
      attr_accessor :name, :namespace

      def initialize(name, namespace = nil)
        @name = name
        @namespace = namespace
      end

      def to_s
        ns = @namespace.reverse.each(&:to_s).join('::')

        "#{@name} (#{ns})"
      end
    end
  end
end
