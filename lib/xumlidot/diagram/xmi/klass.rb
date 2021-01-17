# frozen_string_literal: true

require_relative '../../types'
require_relative 'id'
require_relative 'constant'
require_relative 'superklass'
require_relative '../shared/naming'

module Xumlidot
  class Diagram
    class Xmi
      # Draw the klass
      module Klass
        include ::Xumlidot::Diagram::Xmi::ID
        include ::Xumlidot::Diagram::Shared::Naming

        module Name
          def to_xmi
            map do |constant|
              constant.extend(::Xumlidot::Diagram::Xmi::Constant) unless constant.respond_to?(:to_xmi)
              constant.to_xmi
            end.join
          end
        end

        # TODO: Split this into model and diagram classes
        # class Model
        # end
        # class Diagram
        # end

        def draw_klass
          definition.name.extend(Name)
          xmi = "<ownedMember isAbstract=\"false\" isActive=\"false\" isLeaf=\"false\" name=\"#{definition.name.to_xmi}\" visibility=\"public\" xmi:id=\"#{id}\" xmi:type=\"uml:Class\">"
          xmi += draw_model_inheritance if ::Xumlidot::Options.inheritance
          xmi += extend_and_draw(attributes)
          xmi += extend_and_draw(class_methods)
          xmi += extend_and_draw(instance_methods)
          xmi += "</ownedMember>"
        end

        # Draws a diagram element i.e. the part which is rendered
        def draw_diagram
          xml = %(<uml:DiagramElement preferredShapeType="Class" subject="#{id}" xmi:id="#{id}de">
            </uml:DiagramElement>)

          return xml if @definition.superklass.empty? && @definition.inherited_modules.empty?
          return xml unless ::Xumlidot::Options.inheritance

          xml += draw_diagram_generalisation
        end

        def draw_diagram_generalisation
          xml = ''

          if ! @definition.superklass.empty?
            xml += %(<uml:DiagramElement fromDiagramElement="#{@definition.superklass.id}de" preferredShapeType="Generalization" subject="#{gen_id}" toDiagramElement="#{id}de">
            </uml:DiagramElement>)
          end

          return xml if @definition.inherited_modules.empty?

          @definition.inherited_modules.each do |m|
            next if m.empty?

            xml += %(<uml:DiagramElement fromDiagramElement="#{m.id}de" preferredShapeType="Generalization" subject="#{gen_id}" toDiagramElement="#{id}de">
            </uml:DiagramElement>)
          end

          xml
        end

        # Inheritance has to be drawn both as part of the model
        # and as a part of the diagram
        #
        # general =
        # id = IMPORTANT; will be used to draw the lines in the diagram
        #
        def draw_model_inheritance
          return '' if @definition.superklass.empty? && @definition.inherited_modules.empty?

          xml = ''

          if ! @definition.superklass.empty?
            xml += %(<generalization general="#{@definition.superklass.id}" xmi:id="#{gen_id}" xmi:type="uml:Generalization">
              </generalization>)
          end

          return xml if @definition.inherited_modules.empty?

          @definition.inherited_modules.each do |m|
            next if m.empty?

            xml += %(<generalization general="#{m.id}" xmi:id="#{gen_id}" xmi:type="uml:Generalization">
              </generalization>)
          end
          xml
        end

        def draw_model_composition(composee)
          %(<ownedMember isAbstract="false" isDerived="false" isLeaf="false" xmi:id="#{association_id}" xmi:type="uml:Association">
              <memberEnd xmi:idref="#{association_end_id}"/>
              <ownedEnd aggregation="none" association="#{association_id}" isDerived="false" isDerivedUnion="false" isLeaf="false" isNavigable="true" isReadOnly="false" isStatic="false" type="#{id}" xmi:id="#{association_end_id}" xmi:type="uml:Property">
              </ownedEnd>
              <memberEnd xmi:idref="#{composee.association_end_id}"/>
              <ownedEnd aggregation="composite" association="#{association_id}" isDerived="false" isDerivedUnion="false" isLeaf="false" isNavigable="true" isReadOnly="false" isStatic="false" type="#{composee.id}" xmi:id="#{composee.association_end_id}" xmi:type="uml:Property">
              </ownedEnd>
            </ownedMember>)
        end

        def draw_diagram_composition(composee)
          %(<uml:DiagramElement fromDiagramElement="#{id}de" preferredShapeType="Association" subject="#{association_id}" toDiagramElement="#{composee.id}de">
          </uml:DiagramElement>)
        end

        # Im not happy with this - xmi should not have to
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
