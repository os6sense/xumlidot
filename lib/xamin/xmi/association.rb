module Xamin
  class Association
    attr_accessor :skip
    
    def initialize(owner, relationship)
      @owner, @relationship = owner, relationship
      (@@all ||= []) << self
    end
    
    def associated_class_name
      return @relationship.options[:class_name].to_s.underscore if @relationship.options[:class_name]
      @relationship.name.to_s.singularize
    end
    
    def class_name
      @relationship.active_record.name.underscore.singularize
    end

    def name
      @relationship.name
    end
    
    def self.find_reciprocal(assoc)
      @@all.detect{ |a| assoc.reciprocal?(a) }
    end
    
    def reciprocal?(other)
      (associated_class_name == other.class_name) && (class_name == other.associated_class_name)
    end
    
    def set_bidirectional
      if assoc = Association.find_reciprocal(self)
        @navigable = true
        @reciprocal_name = assoc.name
        self.skip = true unless assoc.skip
      end
    end
    
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
    
    private

    def associated_owner_id
      Model.find(associated_class_name).id rescue nil
    end
    
    def navigable?
      @navigable || false
    end
    
    def reciprocal_name
      @reciprocal_name
    end
  end
end
