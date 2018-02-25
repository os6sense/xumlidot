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

        class Model
        end

        class Diagram
        end

        def draw_klass
          definition.name.extend(Name)
          xmi = "<ownedMember isAbstract=\"false\" isActive=\"false\" isLeaf=\"false\" name=\"#{definition.name.to_xmi}\" visibility=\"public\" xmi:id=\"#{id}\" xmi:type=\"uml:Class\">"
          xmi += draw_model_inheritance
          xmi += extend_and_draw(attributes)
          xmi += extend_and_draw(class_methods)
          xmi += extend_and_draw(instance_methods)
          xmi += "</ownedMember>"
        end

        # Draws a diagram element i.e. the part which is rendered
        def draw_diagram
          xml = %(<uml:DiagramElement preferredShapeType="Class" subject="#{id}" xmi:id="#{id}de">
            </uml:DiagramElement>)

          return xml if @definition.superklass.empty?

          # Diagram generalization
          xml += %(<uml:DiagramElement fromDiagramElement="#{@definition.superklass.id}de" preferredShapeType="Generalization" subject="#{gen_id}" toDiagramElement="#{id}de">
          </uml:DiagramElement>)
        end

        #private

        # Inheritance has to be drawn both as part of the model
        # and as a part of the diagram
        #
        # general =
        # id = IMPORTANT; will be used to draw the lines in the diagram
        #
        def draw_model_inheritance
          return '' if @definition.superklass.empty?
          %(<generalization general="#{@definition.superklass.id}" xmi:id="#{gen_id}" xmi:type="uml:Generalization">
            </generalization>)
        end

        def draw_model_composition(composee)
          %(<ownedMember isAbstract="false" isDerived="false" isLeaf="false" xmi:id="#{association_id}" xmi:type="uml:Association">
              <memberEnd xmi:idref="#{association_end_id}"/>
              <ownedEnd aggregation="none" association="#{association_id}" isDerived="false" isDerivedUnion="false" isLeaf="false" isNavigable="true" isReadOnly="false" isStatic="false" type="#{id}" xmi:id="9JMZlYaD.AACASCI" xmi:type="uml:Property">
              </ownedEnd>
              <memberEnd xmi:idref="#{composee.association_end_id}"/>
            <ownedEnd aggregation="composite" association="#{association_id}" isDerived="false" isDerivedUnion="false" isLeaf="false" isNavigable="true" isReadOnly="false" isStatic="false" type="#{composee.id}" xmi:id="9JMZlYaD.AACASCK" xmi:type="uml:Property">
            </ownedEnd>
            </ownedMember>)
        end

        def draw_diagram_composition(composee)
          %(<uml:DiagramElement fromDiagramElement="#{id}de" preferredShapeType="Association" subject="#{association_id}" toDiagramElement="#{composee.id}de">
          </uml:DiagramElement>)
        end

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
        def draw_identifier
          d = @definition
          [d.name.name, d.name.namespace.reverse].reverse.flatten.join('::')
        end

        def draw_name
          @definition.name.name.join('::')
        end

        def draw_ancestor
          d = @definition
          [d.name, d.namespace.reverse].reverse.flatten.join('::')
        end
      end
    end
  end
end
