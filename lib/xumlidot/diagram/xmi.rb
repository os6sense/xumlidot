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

      # Lookup table for namespace to id
      class NamespaceToId
        def initialize
          @namespace_to_id = {}
        end

        def add(full_namespace, id)
          @namespace_to_id[full_namespace] = id
        end

        def has?(full_namespace)
          @namespace_to_id[full_namespace] != nil
        end

      end

      def initialize(stack, options = nil)
        @stack = stack
        @options = options
        # We need to keep track of the ids assigned in the body for each
        # class.

        @model = [] # We need both model and diagram elements
        @diagram = []
      end

      # Look closely at how its done in dot - thats the right way to go
      def draw
        xml = draw_header
        # First traversal we're just assigning ids to
        # everything so that when we come to draw things
        # we can do a lookup on the ids.
        @stack.traverse do |klass|
          klass.extend(::Xumlidot::Diagram::Xmi::Klass)

          unless @namespace_to_id.has?(klass.draw_identifier)
            @namespace_to_id[klass.draw_identifier] = klass.id

            # we also need to get the id of any superklass
            @namespace_to_id[klass.superklass.draw_identifier] = klass.superklass.id
          end
        end

        # Second traversal we are drawing everything
        @stack.traverse do |klass|
          klass.extend(::Xumlidot::Diagram::Xmi::Klass)

          full_namespace = klass.draw_identifier
          unless @namespace_to_id.has?(full_namespace)
            @namespace_to_id[full_namespace] = id
            @model << klass.draw_model
            @diagram << klass.draw_diagram
          end
        end

        xml += draw_footer
        #puts xml
        pretty_print(xml)
      end

      private

      def draw_header
         %(<?xml version="1.0" encoding="UTF-8"?>
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

      def pretty_print(xml)
        doc = Document.new(xml)
        formatter = REXML::Formatters::Pretty.new
        formatter.compact = true
        formatter.write(doc, $stdout)
      end
    end
  end
end
