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

      module Klass
        include ::Xumlidot::Diagram::Xmi::ID

        module Name
          def to_xmi
            map { |constant| constant.to_xmi }.join
          end
        end

        def draw_model
          definition.name.extend(Name)
          xmi = "<ownedMember isAbstract=\"false\" isActive=\"false\" isLeaf=\"false\" name=\"#{definition.name.to_xmi}\" visibility=\"public\" xmi:id=\"#{id}\" xmi:type=\"uml:Class\">"
          # TODO# Add generalization for superclass
          
          
          xmi += extend_and_draw(attributes)
          xmi += extend_and_draw(class_methods)
          xmi += extend_and_draw(instance_methods)
          xmi += "</ownedMember>"
        end

        def draw_superklass

        end

        # Draws a diagram element i.e. the part which is rendered
        def draw_diagram
          %(<uml:DiagramElement preferredShapeType="Class" subject="#{id}" xmi:id="#{id}de">
               <elementFill color1="Cr:122,207,245,255" color2="" style="1" transparency="0" type="1"/>
               <elementFont bold="false" color="Cr:0,0,0,255" italic="false" name="Dialog" size="11" style="0"/>
               <elementLine color="Cr:0,0,0,255" style="1" transparency="0" weight="1.0"/>
               <CompartmentFont value="none"/>
             </uml:DiagramElement>)
        end

        #private

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

        # Cut and paste from the dot version
        def draw_identifier#(d)
          d = @definition
          [d.name.name, d.name.namespace.reverse].reverse.flatten.join('::')
        end

        def draw_name
          @definition.name.name.join('::')
        end

        def draw_ancestor#(d)
          d = @definition
          [d.name, d.namespace.reverse].reverse.flatten.join('::')
        end

      end

    end
  end
end
