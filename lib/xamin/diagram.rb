
module Xamin
  class Diagram
    def initialize(constants)
      @constants = constants

      # Holds any superclass relationships (applies to dot, possibly
      # not to xmi
      @inheritance = []

      # Holds ancenser tree relationships (applies to dot, possibly
      # not to xmi
      @composition = []
    end

  end
end
