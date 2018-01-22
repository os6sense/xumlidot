require_relative 'id'

module Xamin
  module Xmi
    module Method
      include ::Xamin::Xmi::ID

      def return_id
        @_return_id ||= new_id
      end

      def to_xmi
        method_xmi = "<ownedOperation isAbstract=\"false\" isLeaf=\"false\" isOrdered=\"false\" isQuery=\"false\" isStatic=\"#{superclass_method}\" isUnique=\"true\" name=\"#{name}\" visibility=\"#{visibility}\" xmi:id=\"#{id}\" xmi:type=\"uml:Operation\">"
        method_xmi += "<ownedParameter kind=\"return\" xmi:id=\"#{return_id}\" xmi:type=\"uml:Parameter\"/>"
        args.each do |argument|
          method_xmi += argument.to_xmi
        end
        method_xmi += "</ownedOperation>"
      end
    end
  end
end
