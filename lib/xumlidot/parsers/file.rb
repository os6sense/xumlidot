require 'sexp_processor'
require 'ruby_parser'
require 'pry'

require_relative '../types'
require_relative '../parsers'

module Xumlidot
  module Parsers
    # Takes a file contents (as a string) and parses it into
    # s expressions using ruby parser. The parse method uses
    # the SexpProcessors methods to contert to a graph
    class File < Generic
    end

  end
end
