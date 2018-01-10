require 'sexp_processor'
require 'pry'

module Xamin
  module Parsers
    # Parser for the KLASS DEFINITION ONLY
    #
    # The main parser will handle method, 
    # constants, etc
    #
    # 
    class Klass < MethodBasedSexpProcessor
    end

    def initialize(exp)
      super()

      @exp = exp
      @arguments = Arguments.new
    end

    def to_s
      process(@exp)
      @arguments
    end
 
  end
end
