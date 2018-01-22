require_relative 'diagram/dot'
require_relative 'diagram/xmi'

module Xamin
  class Diagram
    def initialize(stack, options = nil)
      @diagram = ::Xamin::Diagram::Dot.new(stack)
    end

    def draw
      @diagram.draw_header
      @diagram.draw
      @diagram.draw_footer
    end
  end
end
