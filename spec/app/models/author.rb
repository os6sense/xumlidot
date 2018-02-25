
module Outside
  class F < Outside::A
  end
end

module Outside
  class A
    attr_reader :class_a
  end

  class B < A
  end

  class E < Outside::A
  end


  class C < Missing
  end

  class D < Missing
  end
end
