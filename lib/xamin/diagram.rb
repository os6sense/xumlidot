require_relative 'diagram/dot'
require_relative 'diagram/xmi'

module Xamin
  class Diagram
    def initialize(stack, type)
      @stack = stack

      # Holds any superclass relationships (applies to dot, possibly
      # not to xmi
      @inheritance = []

      # Holds ancenser tree relationships (applies to dot, possibly
      # not to xmi
      @composition = []
    end

    def draw
      # traverse
      @stack.traverse do |klass|
        # TODO: Name/type should be dynamic
        klass.extend(::Xamin::Diagram::Dot::Klass)
        puts klass.draw
      end
    end

  end
end
