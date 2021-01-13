# frozen_string_literal: true

require 'spec_helper'

describe ::Xumlidot::Types::InheritedModule do
  subject(:inherited_module) { described_class.new(name, namespace) }

  Foo = Class.new
  Bar = Class.new
  Baz = Class.new

  let(:name) { Baz }
  let(:namespace) { [Foo, Bar] }

  describe '#type=' do
    context 'when type in :extend, :prepend, or :include' do
      before  { inherited_module.type = :extend }
      subject { inherited_module.type }
      it { is_expected.to eq :extend }
    end

    context 'when type NOT in :extend, :prepend, or :include' do
      before  { inherited_module.type = :foobared }
      subject { inherited_module.type }
      it { is_expected.to eq nil }
    end
  end
end
