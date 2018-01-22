require_relative 'id'

module Xumlidot
  module Xmi
    module Model

      def to_xmi
        %Q*
        <UML:Class xmi.id ='#{id}' name = '#{name}'>
          <UML:Classifier.feature>
            #{attributes.map{ |a| a.to_xmi }.join("\n\r\t")}
            #{methods.map{ |m| m.to_xmi }.join("\n\r\t")}
          </UML:Classifier.feature>
        </UML:Class>
        *
      end
    end

  end
end
