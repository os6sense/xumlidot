# frozen_string_literal: true

require_relative 'id'

module Xumlidot
  class Diagram
    class Xmi
      module Argument
        include ::Xumlidot::Diagram::Xmi::ID

        def draw
          xmi = "<ownedParameter kind=\"inout\" name=\"#{name_to_xmi}\" xmi:id=\"#{id}\" xmi:type=\"uml:Parameter\">"
          xmi += "<defaultValue value=\"#{default_to_xmi}\" xmi:id=\"#{default_id}\" xmi:type=\"uml:LiteralString\"/>" if default
          xmi += "</ownedParameter>"
        end

        private

        def name_to_xmi
          name.encode(:xml => :text) if name
        end

        def default_to_xmi
          return default unless default.is_a?(String)
          default.encode(:xml => :text)
        end

        def default_id
          @_default_id ||= new_id
        end
      end
    end
  end
end
