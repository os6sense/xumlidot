# frozen_string_literal: true

require_relative '../../types'
require_relative 'id'

module Xumlidot
  class Diagram
    class Xmi
      module Constant
        def to_xmi
          "#{formatted_namespace}::#{@name}"
        end
      end
    end
  end
end
