# frozen_string_literal: true

module Xamin
  module Diagram
    module Dot
      module Klass

        def draw
          [draw_klass, draw_inheritence, draw_ancestors].join('\r')
        end

        private

        def draw_klass
          "\"#{draw_name}\" [shape=Mrecord, label=\"{#{draw_name}|#{draw_methods}}\"]"
        end

        def draw_name
          @definition.name.name.join('::')
        end

        def draw_methods
          km = @class_methods.map(&:to_s).join('\l')
          km += "|\l|"
          km = @instance_methods.map(&:to_s).join('\l')
        end

        def draw_ancestors
          "\"ApplicationController\" -> \"Test::ExternalController\" [label=\"\", arrowhead=\"none\", arrowtail=\"onormal\"]"
        end

        def draw_inheritence
        end

      end
    end
  end
end
