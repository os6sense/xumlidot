require_relative 'id'

module Xumlidot
  module Xmi
    module Argument
      include ::Xumlidot::Xmi::ID


      def draw
        argument_xmi = "<ownedParameter kind=\"inout\" name=\"#{name}\" xmi:id=\"#{id}\" xmi:type=\"uml:Parameter\">"
        if default
          argument_xmi += "<defaultValue value=\"#{default}\" xmi:id=\"#{default_id}\" xmi:type=\"uml:LiteralString\"/>"
        end
        argument_xmi += "</ownedParameter>"
      end

      private

      def default_id
        @_default_id ||= new_id
      end
    end
  end
end
