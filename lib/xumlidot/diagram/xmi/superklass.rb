# frozen_string_literal: true

require_relative '../../types'
require_relative 'id'

module Xumlidot
  class Diagram
    class Xmi
      module Superklass
        include ::Xumlidot::Diagram::Xmi::ID

        def draw_identifier
          [name, namespace.reverse].reverse.flatten.join('::')
        end
      end
    end
  end
end
