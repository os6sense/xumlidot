module Xamin
  
class Attribute
  MAGIC = ["created_at", "updated_at", "type", "id", "crypted_password", "password_salt", "persistence_token", "perishable_token"]
  
  def initialize(column)
    @column = column
  end
  
  def magic?
    MAGIC.include?(@column.name)
  end
  
  def to_xmi
    "<UML:Attribute name = '#{name}'></UML:Attribute>"
  end
  
private
  
  def name
    "#{@column.name} : #{@column.type}"
  end
end

end
