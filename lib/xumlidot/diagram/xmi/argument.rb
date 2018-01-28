# frozen_string_literal: true

require_relative 'id'

module Xumlidot
  class Diagram
    class Xmi
      module Argument
        include ::Xumlidot::Diagram::Xmi::ID


        def draw
          xmi = "<ownedParameter kind=\"inout\" name=\"#{name}\" xmi:id=\"#{id}\" xmi:type=\"uml:Parameter\">"
          xmi += "<defaultValue value=\"#{default}\" xmi:id=\"#{default_id}\" xmi:type=\"uml:LiteralString\"/>" if default
          xmi += "</ownedParameter>"
        end

        private

        def default_id
          @_default_id ||= new_id
        end
      end
    end
  end
end
