require 'rgl/adjacency'
require 'rgl/implicit'
require 'rgl/traversal'
require_relative 'dot'

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
      binding.pry
      xmi = @tree.vertices[0].to_xmi
      xmi = @tree.vertices[1].to_xmi
      binding.pry

    end
  end
end
