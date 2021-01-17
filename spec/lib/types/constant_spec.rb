# frozen_string_literal: true

require 'spec_helper'

describe ::Xumlidot::Types::Constant do
  subject(:constant) { described_class.new(name, namespace) }

  # rubocop:disable Lint/ConstantDefinitionInBlock
  FooA = Class.new
  BarA = Class.new
  BazA = Class.new
  # rubocop:enable Lint/ConstantDefinitionInBlock

  let(:name) { BazA }
  let(:namespace) { [FooA, BarA] }

  describe '#name' do
    subject { constant.name }
    it { is_expected.to eq BazA }
  end

  describe '#namespace' do
    subject { constant.namespace }
    it { is_expected.to eq [FooA, BarA] }
  end

  describe '#to_s' do
    subject { constant.to_s }
    it { is_expected.to eq 'BazA (BarA::FooA)' }
  end
end
