# frozen_string_literal: true

require 'spec_helper'

describe ::Xumlidot::Types::Attribute do
  subject(:attribute) { described_class.new(:test, read, write) }

  describe '#to)s' do
    subject { attribute.to_s }

    context 'attribute (r+w)' do
      let(:read) { true }
      let(:write) { true }
      it { is_expected.to eq '(r+w) test' }
    end
    context 'attr_reader (r0)' do
      let(:read) { true }
      let(:write) { false }
      it { is_expected.to eq '(ro) test' }
    end
    context 'attribute (r+w)' do
      let(:read) { false }
      let(:write) { true }
      it { is_expected.to eq '(wo) test' }
    end
  end
end
