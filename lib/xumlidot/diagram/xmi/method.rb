# frozen_string_literal: true

require_relative '../../types'
require_relative 'id'

module Xumlidot
  class Diagram
    class Xmi
      module MethodSignature
        include ::Xumlidot::Diagram::Xmi::ID

        # Ugh
        def name_to_xmi
          return '&lt;&lt;' if name == :<<
          return '&gt;&gt;' if name == :>>
        end

        def draw
          xmi = "<ownedOperation isAbstract=\"false\" isLeaf=\"false\" isOrdered=\"false\" isQuery=\"false\" isStatic=\"#{superclass_method}\" isUnique=\"true\" name=\"#{name_to_xmi}\" visibility=\"#{visibility}\" xmi:id=\"#{id}\" xmi:type=\"uml:Operation\">"
          xmi += "<ownedParameter kind=\"return\" xmi:id=\"#{return_id}\" xmi:type=\"uml:Parameter\"/>"
          args.each do |argument|
            argument.extend(::Xumlidot::Diagram::Xmi::Argument)
            xmi += argument.draw
          end
          xmi += "</ownedOperation>"
        end

        private

        def return_id
          @_return_id ||= new_id
        end
      end
    end
  end
end
