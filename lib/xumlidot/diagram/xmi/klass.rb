require_relative 'id'

module Xumlidot
  module Xmi
    module Klass
      include ::Xumlidot::Xmi::ID

      def draw
        klass_xmi = "<ownedMember isAbstract=\"false\" isActive=\"false\" isLeaf=\"false\" name=\"#{definition.name.to_xmi}\" visibility=\"public\" xmi:id=\"#{id}\" xmi:type=\"uml:Class\">"

        class_methods.each do |method|
          klass_xmi += method.draw
        end

        instance_methods.each do |method|
          klass_xmi += method.draw
        end

        klass_xmi += "</ownedMember>"
      end

      private

      def class_methods_to_xmi
      end

      def instance_methods_to_xmi
      end

    end

  end
end
