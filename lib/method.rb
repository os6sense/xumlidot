module Xamin

class Method
  ASSOCIATION_REGEXES = [/^loaded_/, /^set_\w+_target/, /^autosave/, /^create_/, /^build_/,
  /has_many_dependent_destroy_for_\w+/, /validate_associated_records_for_\w+/, /_ids=?$/, /password_confirmation=?/]
  
  def initialize(name)
    @name = name.to_s
  end

  def magic?
    ASSOCIATION_REGEXES.any?{ |r| @name =~ r }
  end
  
  def to_xmi
    "<UML:Operation name = '#{@name}' />"
  end
  
end

end
