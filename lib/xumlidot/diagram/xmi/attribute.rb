require_relative 'id'

module Xumlidot
  module Xmi
    module Attribute
      include ::Xumlidot::Xmi::ID

      def draw
			  attribute_xmi = "<ownedAttribute aggregation=\"none\" isDerived=\"false\" isDerivedUnion=\"false\" isID=\"false\" isLeaf=\"false\" isReadOnly=\"false\" isStatic=\"false\" name=\"#{name}\" visibility=\"#{visibility}\" xmi:id=\"#{id}\" xmi:type=\"uml:Property\">"
			  attribute_xmi += "</ownedAttribute>"
      end

    end
  end
end
