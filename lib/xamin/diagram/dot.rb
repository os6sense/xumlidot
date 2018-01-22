require_relative 'dot/klass'
require_relative 'dot/module'

module Xamin
  class Diagram
    class Dot

      def initialize(stack, options = nil)
        @stack = stack
        @options = options

        # Holds any superclass relationships (applies to dot, possibly
        # not to xmi
        @inheritance = []

        # Holds ancenser tree relationships (applies to dot, possibly
        # not to xmi
        #@composition = []
      end

      # I 'think' that we have to draw any connecting labels AFTER
      # we have drawn the klasses in order to have something to connect
      def draw
        @stack.traverse do |klass|
          klass.extend(::Xamin::Diagram::Dot::Klass)
          puts klass.draw
        end

        @stack.traverse do |klass|
          klass.extend(::Xamin::Diagram::Dot::Klass)
          output = klass.draw_inheritence
          puts output unless output.nil?

          klass.constants.each do |k|
            puts klass.draw_composition(k)
          end
        end

      end

      def draw_header
        puts "digraph graph_title {"
        puts "  graph[overlap=false, splines=true, bgcolor=\"white\"]"
      end

      def draw_footer
        puts "}"
      end

    end
  end
end
