require_relative 'diagram/dot'
require_relative 'diagram/xmi'

module Xumlidot
  class Diagram
    def initialize(stack, options)
      @diagram = if options[:diagram_type] == :dot
                   ::Xumlidot::Diagram::Dot.new(stack, options)
                 else
                   ::Xumlidot::Diagram::Xmi.new(stack, options)
                 end
    end

    def draw
      @diagram.draw
    end
  end
end
