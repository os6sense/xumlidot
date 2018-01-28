# frozen_string_literal: true

require_relative 'id'

module Xumlidot
  class Diagram
    class Xmi
      module Attribute
        include ::Xumlidot::Diagram::Xmi::ID

        # TODO - public/private visibility on attributes
        def draw
          attribute_xmi = "<ownedAttribute aggregation=\"none\" isDerived=\"false\" isDerivedUnion=\"false\" isID=\"false\" isLeaf=\"false\" isReadOnly=\"false\" isStatic=\"false\" name=\"#{name}\" visibility=\"public\" xmi:id=\"#{id}\" xmi:type=\"uml:Property\">"
          attribute_xmi += "</ownedAttribute>"
        end

      end
    end
  end
end
