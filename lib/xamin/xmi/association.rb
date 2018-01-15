require_relative 'id'

# Keeping this but its really a rails related concept
module Xamin
  module Xmi
    module Association
      include ::Xamin::Xmi::ID

      def to_xmi
        %Q|
        <UML:Association name = '#{name}'>
          <UML:Association.connection>
            <UML:AssociationEnd name = '#{name}' isNavigable = '#{navigable?}'>
              <UML:AssociationEnd.participant>
                <UML:Class xmi.idref = '#{@owner.id}'/>
              </UML:AssociationEnd.participant>
            </UML:AssociationEnd>
            <UML:AssociationEnd name = '#{reciprocal_name}' isNavigable = 'true'>
              <UML:AssociationEnd.participant>
                <UML:Class xmi.idref = '#{associated_owner_id}'/>
              </UML:AssociationEnd.participant>
            </UML:AssociationEnd>
          </UML:Association.connection>
        </UML:Association>
        |
      end
    end
  end
end
