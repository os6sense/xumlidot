# frozen_string_literal: true

module Xumlidot
  class Diagram
    class Dot
      module Klass
        def draw
          [draw_klass].compact.join('\r\n')
        end

        def draw_klass
          label = draw_identifier(@definition)
          "\"#{draw_identifier(@definition)}\" [shape=Mrecord, label=\"{#{label}|#{draw_methods}}\"]"
        end

        def draw_composition(composee)
          "\"#{draw_identifier(composee.definition)}\" -> \"#{draw_identifier(@definition)}\" [label=\"\", arrowhead=\"diamond\", arrowtail=\"diamond\"]"
        end

        def draw_inheritence
          return nil if @definition.superklass.empty?
          "\"#{draw_identifier(@definition)}\" -> \"#{draw_ancestor(@definition.superklass)}\" [label=\"\", arrowhead=\"empty\", arrowtail=\"onormal\"]"
        end

        private

        def draw_identifier(d)
          [d.name.name, d.name.namespace.reverse].reverse.flatten.join('::')
        end

        def draw_name
          @definition.name.name.join('::')
        end

        def draw_ancestor(d)
          [d.name, d.namespace.reverse].reverse.flatten.join('::')
        end

        def draw_methods
          km = ''
          km += @attributes.map(&:to_s).join('\l')
          km += '\\l' unless km.end_with?('\\l')

          km += @class_methods.map(&:to_s).join('\l')
          km += '\\l' unless km.end_with?('\\l')
          km += '|' if instance_methods.size.positive?

          km += @instance_methods.map(&:to_s).join('\l')
          km += '\\l' unless km.end_with?('\\l')
          km
        end
      end
    end
  end
end
