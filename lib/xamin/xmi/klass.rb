require_relative 'id'

module Xamin
  module Xmi
    module Klass
      include ::Xamin::Xmi::ID

      def to_xmi
        klass_xmi = "<ownedMember isAbstract=\"false\" isActive=\"false\" isLeaf=\"false\" name=\"#{definition.name}\" visibility=\"#{definition.visibility}\" xmi:id=\"#{id}\" xmi:type=\"uml:Class\">"
        class_methods.each do |method| 
          klass_xmi += method.to_xmi
        end

        instance_methods.each do |method| 
          klass_xmi += method.to_xmi
        end

        klass_xmi += "</ownedMember>"
      end
    end

  end
end
