#class Author < ActiveRecord::Base
  #has_many :books

  #def self.blah
  #end

  #def write()
  #end

  #def study_drug?(form)
    ##form.data._name == "primary" && form.report.report_type == "psp" && StudyService.drugs(form.report).present?
  #end
#end

#class Foo
  #class Bar
  #end
#end

#module FooM
  #module FooI
    #class BazC
    #end
  #end
#end
#

module Amod
  class AClass < Foo

    class << self

    end

    BLAH = []

    somecall

    def public_method_number_1(a)
      x = 1
      y = ''
    end

    private

    def private_method_number_1(a)
      x = 1
      y = ''
    end
  end
end

class Bad::ClassWithOutInheritance
end

class Bad::ClassWithInheritance < Foo
end

class InheritsThreeWIthLeading < ::Foo::Bar::Baz
end

class InheritsTwo < Foo::Bar
end

class InheritsOne  < Foo
end

class InheritsZero
end

#class MyAuthor < Author
  #def empty(a); end
  #def multiple(a, b, c = nil); end
  #def with_nil(a = nil); end
  #def empty_array(b = []); end
  #def populated_array(c = [:foo, 2]); end
  #def integer_default(d = 1); end
  #private
  #def string_default(e = 'hello'); end
  #def symbol_default(f = :hello); end
  #protected
  #def fwarg_default(g: :hello); end

  #private

  #def private_method
  #end

  #protected

  #def protected_method
  #end

  #public

  #def public_method
  #end

  #class << self
    #def klass_method
    #end

    #private

    #def private_klass_method
    #end
  #end
#end

#module TopM
  #class SecondC
    #module ThirdM
      #class FourthC < ::MyAuthor
        #def fouth_meth()
        #end
      #end
    #end
  #end
#end
