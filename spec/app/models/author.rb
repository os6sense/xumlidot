# frozen_string_literal: true

module Outside
  class F < Outside::A
  end
end

module Outside
  class A
    attr_reader :class_a

    def a_method(foo, bar = 1, baz = [], bat: nil) end

    def b_method(foo, bar = 'string', baz = {}, bat:) end
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
