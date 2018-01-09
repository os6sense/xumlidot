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

class Foo
  class Bar
  end
end
class MyAuthor < Author
  def my_author(a, b = [:foo, 2], f = [], d = 1 )
  end

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
end

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
