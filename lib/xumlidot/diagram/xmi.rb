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

      class Elements < Array
        def draw
          xml = header
          each { |de| xml += de }
          xml += yield if block_given?
          xml += footer
        end

        private

        def header; '' end
        def footer; '' end
      end

      class ModelAssociationElements < Elements
      end
      class DiagramAssociationElements < Elements
      end

      class ModelElements < Elements
        private

        def header
          %(<uml:Model name="SIMPLE XMI TEST" xmi:id="jcBKnwaFYHEAAQV_">)
        end

        def footer
          %(</uml:Model>)
        end
      end

      class DiagramElements < Elements
        private

        def header
          %(<uml:Diagram diagramType="ClassDiagram" documentation="" name="This is the title of the diagram" toolName="Visual Paradigm" xmi:id="QfZKnwaFYHEAAQj3">
              <uml:Diagram.element>)
        end

        def footer
          %(  </uml:Diagram.element>
            </uml:Diagram>)
        end
      end

      # We need to keep track of the ids assigned in the body for each class.
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

        def [](name)
          @namespace_to_id[name]
        end

        def []=(name, value)
          @namespace_to_id[name] = value
        end
      end

      def initialize(stack, options = nil)
        @stack = stack
        @options = options
        @namespace_to_id = NamespaceToId.new

        @model = ModelElements.new
        @diagram = DiagramElements.new
        @model_associations = ModelAssociationElements.new
        @diagram_associations = DiagramAssociationElements.new
      end

      # Look closely at how its done in dot - thats the right way to go
      def draw
        # First traversal we're just assigning ids to everything so that when
        # we come to draw things we can do a lookup on the ids for any composition
        # aggregation or subclass relationships.
        @stack.traverse do |klass|
          klass.extend(::Xumlidot::Diagram::Xmi::Klass)
          klass.superklass.extend(::Xumlidot::Diagram::Xmi::Superklass) unless klass.superklass.name.nil?

          next if @namespace_to_id.has?(klass.draw_identifier)
          @namespace_to_id[klass.draw_identifier] = klass.id
        end

        # Second traversal we are drawing everything
        @stack.traverse do |klass|
          # resolve the superclass id to that of an existing class with an id
          unless klass.superklass.name.nil?
            id = @namespace_to_id[klass.superklass.draw_identifier]
            klass.superklass.force_id(id)
          end

          @model << klass.draw_klass
          @diagram << klass.draw_diagram

          klass.constants.each do |k|
            @model_associations << klass.draw_model_composition(k)
            @diagram_associations<< klass.draw_diagram_composition(k)
          end
        end

        xml = header
        xml += @model.draw { @model_associations.draw }
        xml += @diagram.draw { @diagram_associations.draw }
        xml += footer
        pretty_print(xml)
      end

      private

      def header
         %(<?xml version="1.0" encoding="UTF-8"?>
        <xmi:XMI xmi:version="2.1" xmlns:uml="http://schema.omg.org/spec/UML/2.0" xmlns:xmi="http://schema.omg.org/spec/XMI/2.1">
          <xmi:Documentation exporter="Visual Paradigm" exporterVersion="7.0.2">
          </xmi:Documentation>)
      end

      def footer
        %(</xmi:XMI>)
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
