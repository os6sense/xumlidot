require_relative 'dot/klass'
require_relative 'dot/module'

module Xumlidot
  class Diagram
    class Dot

      def initialize(stack, options = nil)
        @stack = stack
        @options = options
      end

      # I 'think' that we have to draw any connecting labels AFTER
      # we have drawn the klasses in order to have something to connect
      def draw
        draw_header
        @stack.traverse do |klass|
          klass.extend(::Xumlidot::Diagram::Dot::Klass)
          puts klass.draw
        end

        @stack.traverse do |klass|
          # Check - i shouldnt need to extend twice
          klass.extend(::Xumlidot::Diagram::Dot::Klass)
          output = klass.draw_inheritence
          puts output unless output.nil?

          klass.constants.each do |k|
            puts klass.draw_composition(k)
          end
        end
        draw_footer
      end

      private

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
