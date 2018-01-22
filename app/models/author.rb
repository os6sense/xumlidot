
module A
 class A2 < Foo::Bar::Baz
   class << self
     def class_method
     end

   end

   def public_method
   end

   private
   def private_method
   end
 end
end

module B
  class A2 < Foo::Bar::Baz
  end
end

