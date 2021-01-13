# frozen_string_literal: true

require 'spec_helper'

describe ::Xumlidot::Types::Constant do
  subject(:constant) { described_class.new(name, namespace) }

  Foo = Class.new
  Bar = Class.new
  Baz = Class.new

  let(:name) { Baz }
  let(:namespace) { [Foo, Bar] }

  describe '#name' do
    subject { constant.name }
    it { is_expected.to eq Baz }
  end

  describe '#namespace' do
    subject { constant.namespace }
    it { is_expected.to eq [Foo, Bar] }
  end

  describe '#to_s' do
    subject { constant.to_s }
    it { is_expected.to eq 'Baz (Bar::Foo)' }
  end
end
