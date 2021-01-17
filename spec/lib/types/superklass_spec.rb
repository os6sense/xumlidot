# frozen_string_literal: true

require 'spec_helper'

describe ::Xumlidot::Types::Superklass do
  subject(:superklass) { described_class.new(name, namespace) }

  # rubocop:disable Lint/ConstantDefinitionInBlock
  FooB = Class.new
  BarB = Class.new
  BazB = Class.new
  BooB = Class.new
  # rubocop:enable Lint/ConstantDefinitionInBlock

  let(:name) { BazB }
  let(:namespace) { [FooB, BarB] }

  describe '#<<' do
    context 'when constant is anything but "::"' do
      before { superklass << BooB }
      subject { superklass.namespace }

      it { is_expected.to eq [FooB, BarB, BooB] }

      it 'leaves the name unchanged' do
        expect(superklass.name).to eq BazB
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
