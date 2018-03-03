module Xumlidot
  class Diagram
    module Shared
      module Naming
        def draw_identifier(d = @definition)
          [d.name.name, d.name.namespace.reverse].reverse.flatten.join('::')
        end

        def draw_name
          @definition.name.name.join('::')
        end

        def draw_ancestor(d = @definition)
          [d.name, d.namespace.reverse].reverse.flatten.join('::')
        end
      end
    end
  end
end
