# frozen_string_literal: true

require_relative 'id'

module Xumlidot
  class Diagram
    class Xmi
      module Attribute
        include ::Xumlidot::Diagram::Xmi::ID

        # TODO: - public/private visibility on attributes
        def draw
          '<ownedAttribute aggregation="none" isDerived="false" isDerivedUnion="false" isID="false"' \
            " isLeaf=\"false\" isReadOnly=\"false\" isStatic=\"false\" name=\"#{name_to_xmi}\"" \
            " visibility=\"public\" xmi:id=\"#{id}\" xmi:type=\"uml:Property\"></ownedAttribute>"
        end

        def name_to_xmi
          name&.encode(xml: :text)
        end
      end
    end
  end
end
