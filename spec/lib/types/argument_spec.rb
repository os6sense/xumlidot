# frozen_string_literal: true

require 'spec_helper'

describe ::Xumlidot::Types::Argument do
  subject(:argument) { described_class.new }

  describe '#name/#name=' do
    context 'when it contains an ampersand' do
      subject { argument.name }
      before do
        argument.name = '&foo&'
      end

      it { is_expected.to eq 'foo' }
    end
  end

  describe '#to_s' do
    subject { argument.to_s }

    before do
      argument.name = 'foo'
      argument.assign = '='
      argument.default = default
    end

    context 'when default equals :nil' do
      let(:default) { :nil }
      it { is_expected.to eq 'foo = nil' }
    end

    context 'when default nil' do
      let(:default) { nil }
      it { is_expected.to eq 'foo =' }
    end

    context 'when default is a string' do
      let(:default) { 'string' }
      it { is_expected.to eq 'foo = string' }
    end

    context 'when default is a Symbol' do
      let(:default) { :foo }
      it { is_expected.to eq 'foo = :foo' }
    end

    context 'when default is a Hash' do
      let(:default) { {} }
      it { is_expected.to eq 'foo = {}' }
    end

    context 'when default is an Array' do
      let(:default) { [1, 2] }
      it { is_expected.to eq 'foo = [1, 2]' }
    end

    context 'when default is a Float' do
      let(:default) { 1.2 }
      it { is_expected.to eq 'foo = 1.2' }
    end
  end
end
