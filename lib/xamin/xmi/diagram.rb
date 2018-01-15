require_relative 'model'
require_relative 'id'

module Xamin
  module Xmi
    class Diagram

      def initialize(graph)
        @graph = graph
      end

      def filename
        "#{name}.xmi"
      end

      def to_xmi
        @xmi = @graph.to_xmi
        template { @xmi.to_s }
      end

      private

      def template
        %Q|
        <?xml version = '1.0' encoding = 'UTF-8' ?>
        <XMI xmi.version = '1.2' xmlns:UML = 'org.omg.xmi.namespace.UML' timestamp = '#{Time.now}'>
          <XMI.header><XMI.metamodel xmi.name="UML" xmi.version="1.4"/></XMI.header>
          <XMI.content>
            <UML:Model name = '#{name}'>
              <UML:Namespace.ownedElement>
                #{yield}
              </UML:Namespace.ownedElement>
            </UML:Model>
          </XMI.content>
        </XMI>
        |
      end
    end
  end
end
