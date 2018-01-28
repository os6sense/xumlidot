require_relative 'xmi/argument'
#require_relative 'xmi/association'
require_relative 'xmi/attribute'
#require_relative 'xmi/diagram'
require_relative 'xmi/klass'
require_relative 'xmi/method'
#require_relative 'xmi/module'

require "rexml/document"

module Xumlidot
  class Diagram
    class Xmi

      include REXML

      def initialize(stack, options = nil)
        @stack = stack
        @options = options
        # We need to keep track of the ids assigned in the body for
        # each class.
        @diagram_ids = []
      end

      def draw
        xml = draw_header

        @stack.traverse do |klass|
          klass.extend(::Xumlidot::Diagram::Xmi::Klass)

          @diagram_ids << klass.id
          xml += klass.draw
        end

        xml += draw_footer
        #puts xml
        pretty_print(xml)
      end

      private

      def draw_header
        xml = %(<?xml version="1.0" encoding="UTF-8"?>
        <xmi:XMI xmi:version="2.1" xmlns:uml="http://schema.omg.org/spec/UML/2.0" xmlns:xmi="http://schema.omg.org/spec/XMI/2.1">
          <xmi:Documentation exporter="Visual Paradigm" exporterVersion="7.0.2">
          </xmi:Documentation>
          <uml:Model name="SIMPLE XMI TEST" xmi:id="jcBKnwaFYHEAAQV_">
        )
      end

      def draw_footer
        xml = %(
            </uml:Model>
            <uml:Diagram diagramType="ClassDiagram" documentation="" name="This is the title of the diagram" toolName="Visual Paradigm" xmi:id="QfZKnwaFYHEAAQj3">
              <uml:Diagram.element>
        )

        @diagram_ids.each do |id|
          xml += xmi_diagram_element(id)
        end

        xml += %(
              </uml:Diagram.element>
            </uml:Diagram>
          </xmi:XMI>
        )
      end

      private

      def xmi_diagram_element(id)
        xml = %(<uml:DiagramElement preferredShapeType="Class" subject="#{id}" xmi:id="#{id}de">
             <elementFill color1="Cr:122,207,245,255" color2="" style="1" transparency="0" type="1"/>
             <elementFont bold="false" color="Cr:0,0,0,255" italic="false" name="Dialog" size="11" style="0"/>
             <elementLine color="Cr:0,0,0,255" style="1" transparency="0" weight="1.0"/>
             <CompartmentFont value="none"/>
           </uml:DiagramElement>)
      end

      def pretty_print(xml)
        doc = Document.new(xml)
        formatter = REXML::Formatters::Pretty.new
        formatter.compact = true
        formatter.write(doc, $stdout)
      end
    end
  end
end
