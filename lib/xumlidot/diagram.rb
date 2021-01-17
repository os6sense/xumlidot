# frozen_string_literal: true

require_relative 'diagram/dot'
require_relative 'diagram/xmi'

module Xumlidot
  class Diagram
    def initialize(stack, _options)
      @diagram = if ::Xumlidot::Options.diagram_type == :dot
                   ::Xumlidot::Diagram::Dot.new(stack)
                 else
                   ::Xumlidot::Diagram::Xmi.new(stack)
                 end
    end

    def draw
      @diagram.draw
    end
  end
end
