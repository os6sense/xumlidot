# frozen_string_literal: true

require_relative '../../types'
require_relative 'id'

module Xumlidot
  class Diagram
    class Xmi
      module Klass
        include ::Xumlidot::Diagram::Xmi::ID

        module Name
          def to_xmi
            map do |constant|
              constant.to_xmi
            end.join
          end
        end

        def draw
          definition.name.extend(Name)

          xmi = "<ownedMember isAbstract=\"false\" isActive=\"false\" isLeaf=\"false\" name=\"#{definition.name.to_xmi}\" visibility=\"public\" xmi:id=\"#{id}\" xmi:type=\"uml:Class\">"

          xmi += extend_and_draw(attributes)
          xmi += extend_and_draw(class_methods)
          xmi += extend_and_draw(instance_methods)
          xmi += "</ownedMember>"
        end

        private

        # Im not happy with this design - xmi should not have to
        # know about types and it should be a method
        def extend_and_draw(collection)
          collection.map do |member|
            case member
            when ::Xumlidot::Types::MethodSignature
              member.extend(::Xumlidot::Diagram::Xmi::MethodSignature)
            when ::Xumlidot::Types::Attribute
              member.extend(::Xumlidot::Diagram::Xmi::Attribute)
            end
            member.draw
          end.join(' ')
        end

      end

    end
  end
end
