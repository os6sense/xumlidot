# frozen_string_literal: true

require_relative '../shared/naming'

module Xumlidot
  class Diagram
    class Dot
      module Method
        def to_dot
          to_s.gsub('{}', '\{\}')
        end
      end

      module Attribute
        def to_dot
          to_s
        end
      end

      module Klass
        include ::Xumlidot::Diagram::Shared::Naming
        def draw
          [draw_klass].compact.join('\r\n')
        end

        def draw_klass
          label = draw_identifier(@definition)
          "\"#{draw_identifier(@definition)}\" [shape=Mrecord, label=\"{#{label}|#{draw_methods}}\"]"
        end

        def draw_composition(composee)
          "\"#{draw_identifier(composee.definition)}\"" \
            " -> \"#{draw_identifier(@definition)}\"" \
            ' [label="", arrowhead="diamond", arrowtail="diamond"]'
        end

        def draw_inheritance # rubocop:disable Metrics/AbcSize
          return nil if @definition.superklass.empty? && @definition.inherited_modules.empty?

          dot = ''
          unless @definition.superklass.empty?
            dot += "\"#{draw_identifier(@definition)}\"" \
                   " -> \"#{draw_ancestor(@definition.superklass)}\"" \
                   " [label=\"\", arrowhead=\"empty\", arrowtail=\"onormal\"]\n"
          end

          return dot if @definition.inherited_modules.empty?

          @definition.inherited_modules.each do |m|
            next if m.empty?

            dot += "\"#{draw_identifier(@definition)}\"" \
                   " -> \"#{draw_ancestor(m)}\"" \
                   " [label=\"#{m.type}s\", arrowhead=\"empty\", arrowtail=\"onormal\"]\n"
          end

          dot
        end

        private

        def draw_methods # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
          @attributes.each { |a| a.extend(Attribute) }
          @class_methods.each { |a| a.extend(Method) }
          @instance_methods.each { |a| a.extend(Method) }

          km = ''
          km += @attributes.map(&:to_dot).join('\l')
          km += '\\l' unless km.end_with?('\\l')

          km += @class_methods.map(&:to_dot).join('\l')
          km += '\\l' unless km.end_with?('\\l')
          km += '|' if instance_methods.size.positive?

          km += @instance_methods.map(&:to_dot).join('\l')
          km += '\\l' unless km.end_with?('\\l')
          km
        end
      end
    end
  end
end
