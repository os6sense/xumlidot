# xamin - RoR xmi generator
#
# Copyright 2009-2010 - Brian Lonsdorf
# See COPYING for more details

# xamin model diagram
module Xamin
  
class Diagram

  def initialize
    load_environment
    load_classes
  end
  
  def filename
    "#{name}.xmi"
  end

  def to_xmi
    @xmi = models.map(&:to_xmi)
    @xmi << associations.map{ |a| a.to_xmi unless a.skip }
    template { @xmi.to_s }
  end

private

  def associations
    return @associations if @associations
    a = models.map(&:associations).flatten.uniq
    a.each(&:set_bidirectional)
    @associations = a
  end

  # Prevents Rails application from writing to STDOUT
  def disable_stdout
    @old_stdout = STDOUT.dup
    STDOUT.reopen(PLATFORM =~ /mswin/ ? "NUL" : "/dev/null")
  end

  def enable_stdout
    STDOUT.reopen(@old_stdout)
  end
  
  def files
    f = Dir.glob("app/models/**/*.rb")
    f += Dir.glob("app/policies/**/*.rb")
    f += Dir.glob("app/services/**/*.rb")
  end
  
  def models
    @models ||= files.map{ |f| Model.new(f) }
  end
  
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
  
  def load_classes
    without_stdout{ files.sort.each {|m| require m } }
  rescue LoadError
    print_error "model classes" && raise
  end
  
  def load_environment
    begin
      disable_stdout
      require "config/environment"
      enable_stdout
    rescue LoadError
      enable_stdout
      print_error "application environment"
      raise
    end
  end
  
  def name
    FileUtils.pwd.split("/").last.titleize
  end
  
  def print_error(type)
    STDERR.print "Error loading #{type}.  Make sure you're running this at the root dir. \n"
  end
  
  def without_stdout
    disable_stdout
    yield
    enable_stdout
  end

end

end
