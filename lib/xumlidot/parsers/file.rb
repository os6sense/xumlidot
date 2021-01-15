# frozen_string_literal: true

require_relative '../parsers'
require_relative '../types'

module Xumlidot
  module Parsers
    # Takes a file contents (as a string) and parses it into
    # s expressions using ruby parser. The parse method uses
    # the SexpProcessors methods to contert to a graph
    class File < Generic
    end
  end
end
