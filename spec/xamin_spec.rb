require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Xumlidot" do
  before(:each) do
    allow_any_instance_of(Xumlidot::Diagram).to receive(:load_environment).and_return(true)
    allow_any_instance_of(Xumlidot::Diagram).to receive(:files).and_return(["app/models/author.rb", "app/models/book.rb"])
    @diagram = Xumlidot::Diagram.new
    @xmi = @diagram.to_xmi
  end
  
  describe "Objects" do
    it "should have a class with the name Author" do
      @xmi.should match(/Class .*? name = 'Author'>/)
    end
    
    it "should have a first_name attribute" do
      @xmi.should match(/Attribute name = 'first_name : string'>/)
    end
    
    it "should have a method named 'write'" do
      @xmi.should match(/Operation name = 'write'/)
    end
  end
  
  describe "Associations" do
    
    it "should have an association named books that's navigable" do
      @xmi.should match(/AssociationEnd name = 'books' isNavigable = 'true'>/)
    end
    
    it "should have an association named author that's navigable" do
      @xmi.should match(/AssociationEnd name = 'author' isNavigable = 'true'>/)
    end
    
    it "should point to the book's id to reference the class" do
      @xmi.should match(/AssociationEnd.participant>\s+<UML:Class xmi.idref = 'Book_\S+/)
    end
    
    it "should point to the author's id to reference the class" do
      @xmi.should match(/AssociationEnd.participant>\s+<UML:Class xmi.idref = 'Author_\S+/)
    end
    
  end
end
