require_relative 'diagram/dot'
require_relative 'diagram/xmi'

module Xumlidot
  class Diagram
    def initialize(stack, options = nil)
      @diagram = ::Xumlidot::Diagram::Dot.new(stack)
      #@diagram = ::Xumlidot::Diagram::Xmi.new(stack)
    end

    def draw
      @diagram.draw
    end
  end
end
