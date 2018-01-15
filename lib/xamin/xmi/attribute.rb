require_relative 'id'

module Xamin
  module Xmi
    module Attribute

      def to_xmi
        "<UML:Attribute name = '#{name}'></UML:Attribute>"
      end

    end
  end
end
