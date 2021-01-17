# frozen_string_literal: true

require 'spec_helper'

describe ::Xumlidot::Types::Superklass do
  subject(:superklass) { described_class.new(name, namespace) }

  # rubocop:disable Lint/ConstantDefinitionInBlock
  Foo = Class.new
  Bar = Class.new
  Baz = Class.new
  Boo = Class.new
  # rubocop:enable Lint/ConstantDefinitionInBlock

  let(:name) { Baz }
  let(:namespace) { [Foo, Bar] }

  describe '#<<' do
    context 'when constant is anything but "::"' do
      before { superklass << Boo }
      subject { superklass.namespace }

      it { is_expected.to eq [Foo, Bar, Boo] }

      it 'leaves the name unchanged' do
        expect(superklass.name).to eq Baz
      end
    end
  end

  describe '#to_klass' do
    context 'when type in :extend, :prepend, or :include' do
      subject { superklass.to_klass }

      it { is_expected.to be_a ::Xumlidot::Types::Klass }
    end
  end
end
