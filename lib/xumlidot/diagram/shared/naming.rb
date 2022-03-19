# frozen_string_literal: true
module Xumlidot
  class Diagram
    module Shared
      module Naming
        def draw_identifier(definition = @definition)
          [definition.name.name, definition.name.namespace.reverse].reverse.flatten.join('::')
        end

        def draw_name
          @definition.name.name.join('::')
        end

        def draw_ancestor(definition = @definition)
          [definition.name, definition.namespace.reverse].reverse.flatten.join('::')
        end
      end
    end
  end
end
