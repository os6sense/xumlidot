# frozen_string_literal: true

require_relative 'dot/klass'
require_relative 'dot/module'

module Xumlidot
  class Diagram
    class Dot
      def initialize(stack)
        @stack = stack
        @output = []
      end

      # We have to draw any connecting labels AFTER we have drawn the klasses
      # in order to have something to connect.
      def draw # rubocop:disable Metrics/AbcSize
        @output << header
        @stack.traverse do |klass|
          klass.extend(::Xumlidot::Diagram::Dot::Klass)
          @output << klass.draw
        end

        @stack.traverse do |klass|
          # Check - i shouldn't need to extend twice
          klass.extend(::Xumlidot::Diagram::Dot::Klass)

          if ::Xumlidot::Options.inheritance
            output = klass.draw_inheritance
            @output << output unless output.nil?
          end

          if ::Xumlidot::Options.composition
            klass.constants.each do |k|
              @output << klass.draw_composition(k)
            end
          end
        end
        @output << footer

        @output.uniq.each { |l| puts l }
      end

      private

      def header
        %(digraph graph_title {
            graph[overlap=false, splines=true, bgcolor="white"])
      end

      def footer
        '}'
      end
    end
  end
end
