# frozen_string_literal: true

module Xamin
  class Diagram
    module Dot
      module Klass

        def draw
          [draw_klass, draw_inheritence, draw_ancestors].compact.join('\r\n')
        end

        private

        def draw_klass
          "\"#{draw_name}\" [shape=Mrecord, label=\"{#{draw_name}|#{draw_methods}}\"]"
        end

        def draw_name
          @definition.name.name.join('::')
        end

        def draw_methods
          km = ''
          km += @class_methods.map(&:to_s).join('\l')
          km += "|\l|" if km != '' && @instance_methods.size > 0
          km += @instance_methods.map(&:to_s).join('\l')
        end

        def draw_ancestors
          nil
          #"\"ApplicationController\" -> \"Test::ExternalController\" [label=\"\", arrowhead=\"none\", arrowtail=\"onormal\"]"
        end

        def draw_inheritence
          nil
        end

      end
    end
  end
end
