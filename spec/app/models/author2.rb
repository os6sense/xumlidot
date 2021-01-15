# frozen_string_literal: true

module Outside
  class G < B
  end
end

module FooBar
end

module Outside
  class G
    class A1
      include FooBar
      extend FooBar
    end
  end
end

module Outside
  class G
    class A2
    end
  end
end

module Outside
  class G
    class A3
    end
  end
end
