module Xamin
  module Xmi
    module Method

      def to_xmi
        "<UML:Operation name = '#{@name}' />"
      end

    end
  end
end
