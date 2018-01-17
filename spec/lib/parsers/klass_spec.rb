require 'spec_helper'

module_and_class_nesting = %Q(
  module A
    class B
      module C
        class D
        end
      end
    end
  end

  module A
    class B
      module C
        class E
        end
      end
    end
  end
)
# From the above module A::B::C should contain classes D and E

class_inheritance = %Q(
  class E::F
    BAR = :bar
  end

  module A
    class B
      class C < E::F
        FOO = :foo
      end

      class << self
      end
    end
  end
)
# To do - we know the class name is incorrect for E::F


# Hmm I think we're decribing the parser here
describe ::Xamine::Types::Klass do

  describe 'module_nesting' do

    let(:parsed) do 
      RubyParser.new.parse(module_nesting) # .tap { |sexp| 2.times { sexp.shift }}.first
    end
    subject { described_class.new(parsed).to_s }

    context 'when it has a single argument' do
      let(:arguments) { 'a' }
      it { is_expected.to eq 'a' }
    end

  end
end
