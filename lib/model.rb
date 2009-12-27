# xamin - RoR xmi generator
#
# Copyright 2009-2010 - Brian Lonsdorf
# See COPYING for more details

# xamin model

module Xamin

class Model
  
  def initialize(filename)
    @klass = extract_class_name(filename).constantize
    (@@all ||= []) << self
  end
  
  def associations
    return @associations if @associations
    return [] unless active_record?
    assocs = (@klass.reflect_on_all_associations + @klass.superclass.reflect_on_all_associations).uniq
    @associations = assocs.map{ |a| Association.new(self, a) }
  end
  
  def id
    @id ||= "#{@klass.name}_#{rand(100)}"
  end
  
  def name
    superclass ? "#{@klass.name} &lt; #{superclass}" : @klass.name
  end
  
  def self.find(name)
    @@all.detect{ |m| m.name.to_s.underscore == name.to_s.underscore }
  end
  
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
  
private
  
  def active_record?
    @klass.respond_to?(:reflect_on_all_associations) # eh...
  end
  
  def attributes
    return @attributes if @attributes
    return [] unless active_record?
    attrs = @klass.content_columns.map{ |c| Attribute.new(c)  }
    @attributes = attrs.select{ |a| !a.magic? }
  end
  
  def methods
    return @methods if @methods
    meths = @klass.public_instance_methods(false).map{ |m| Method.new(m)  }
    @methods = meths.select{ |m| !m.magic? }
  end
  
  # Extract class name from filename
  def extract_class_name(filename)
    filename.split('/')[2..-1].collect { |i| i.camelize }.join('::').chomp(".rb")
  end
  
  def superclass
    @klass.superclass unless [ActiveRecord::Base, Object].include?(@klass.superclass) rescue nil
  end
  
end

end
