module Xamin
  module Types
    # representation for class information
    #
    class Klass
      attr_accessor :name, :namespace, :superklass
      def initialize
        @name = []
        @superklass = []
      end

      def to_s
        "#{namespace.reverse} #{name} < #{superklass.reverse} "
      end
    end
  end
end
