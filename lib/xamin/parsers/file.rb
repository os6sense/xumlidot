require 'sexp_processor'
require 'ruby_parser'
require 'pry'

require_relative '../types'
require_relative '../parsers'

module Xamin
  module Parsers
    # THE HARD PARTS
    #
    # FOR CLASS DIAGRAM
    # - Inheritance is ignored need to parse and attach (for the graph)
    #
    # - need to keep a track of the types of variables to that we know
    #   what the receivers class is i.e. uses.
    #
    # - need to identify if methods are public/private/protected: DONE
    # - Parse arguments: DONE (partially - a few edge cases remain)

    # TODO - change the inheritance type; we should aim to inherit
    #        from a lower level parser since we are not using everything
    #        from the MethodBasedSexpProcessor
    #
    # Takes a file contents (as a string) and parses it into
    # s expressions using ruby parser. The parse method uses
    # the SexpProcessors methods to contert to a graph
    class File < Generic# MethodBasedSexpProcessor
    end

  end
end
