require 'rgl/adjacency'
require 'rgl/implicit'
require 'rgl/traversal'

        require "rexml/document"
require_relative 'dot'
require 'awesome_print'

module Xamin
  class Trees < Array
  end

  class Tree
    def initialize
      @tree = RGL::DirectedAdjacencyGraph.new
    end

    def add_class(c)
      parent = find(c.definition.superklass)

      if parent
        parent.add_edge(m, sclass)
      else
        @tree.add_vertex(c)
      end
    end

    def add_module(m)
      binding.pry

      parent = find(m.definition.superklass)
      if parent
        parent.add_edge(m)
      else
        @tree.add_vertex(m)
      end
    end

    def find(node)
      return false
      #start = g.detect { |x| true }
      #g.bfs_search_tree_from(start)
    end

    def to_dot
      #@tree.print_dotted_on
      #@tree.dotty
    end

    def to_xmi
      diagram_ids = []


      xml = @tree.vertices.map do |v| 
        diagram_ids << v.id
        v.to_xmi 
      end

      xml = [xmi_header, xml, xmi_footer(diagram_ids)].join(' ')
      doc = Document.new(xml)
      puts doc.to_s
    end

    def xmi_header
      %Q(<?xml version="1.0" encoding="UTF-8"?>
      <xmi:XMI xmi:version="2.1" xmlns:uml="http://schema.omg.org/spec/UML/2.0" xmlns:xmi="http://schema.omg.org/spec/XMI/2.1">
        <xmi:Documentation exporter="Visual Paradigm" exporterVersion="7.0.2">
        </xmi:Documentation>
        <uml:Model name="SIMPLE XMI TEST" xmi:id="jcBKnwaFYHEAAQV_">
      )

    end

        include REXML  # so that we don't have to prefix everything with REXML::...
    def xmi_footer(diagram_ids)
      xml = %Q(
          </uml:Model>
          <uml:Diagram diagramType="ClassDiagram" documentation="" name="This is the title of the diagram" toolName="Visual Paradigm" xmi:id="QfZKnwaFYHEAAQj3">
            <uml:Diagram.element>
      )

      diagram_ids.each do |id|
        xml += xmi_diagram_element(id)
      end

      xml += %Q(
            </uml:Diagram.element>
          </uml:Diagram>
        </xmi:XMI>
      )
    end


    def xmi_diagram_element(id)
      #%Q(<uml:DiagramElement geometry="0,0,149,138" preferredShapeType="Class" subject="#{id}" xmi:id="WSFKnwaFYHEAAQkB">
      %Q(<uml:DiagramElement preferredShapeType="Class" subject="#{id}" xmi:id="#{id}de">
           <elementFill color1="Cr:122,207,245,255" color2="" style="1" transparency="0" type="1"/>
           <elementFont bold="false" color="Cr:0,0,0,255" italic="false" name="Dialog" size="11" style="0"/>
           <elementLine color="Cr:0,0,0,255" style="1" transparency="0" weight="1.0"/>
           <CompartmentFont value="none"/>
         </uml:DiagramElement>)
    end
  end
end
