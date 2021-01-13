# frozen_string_literal: true

require 'spec_helper'

describe ::Xumlidot::Parsers::Args do
  let(:parsed) do
    RubyParser.new.parse(method).tap { |sexp| 2.times { sexp.shift }}.first
  end
  let(:method) { "def method(#{arguments}); end" }
  subject { described_class.new(parsed).to_s }

  context 'when passed an s expression' do
    context 'when it has a single argument' do
      let(:arguments) { 'a' }
      it { is_expected.to eq 'a' }
    end

    context 'when an argument has a default' do
      context 'of nil' do
        let(:arguments) { 'a = nil' }
        it { is_expected.to eq 'a = nil' }
      end

      context 'of an integer' do
        let(:arguments) { 'a = 1' }
        it { is_expected.to eq 'a = 1' }
      end

      context 'of a string' do
        let(:arguments) { 'a = "foo"' }
        xit { is_expected.to eq 'a = "foo"' }
      end

      context 'of a symbol' do
        let(:arguments) { 'a = :sym' }
        it { is_expected.to eq 'a = :sym' }
      end

      context 'of an empty array' do
        let(:arguments) { 'a = []' }
        it { is_expected.to eq 'a = []' }
      end

      context 'of a const' do
        context 'when a single constant' do
          let(:arguments) { 'a = Foo' }
          it { is_expected.to eq 'a = Foo' }
        end

        context 'when multiple constant' do
          let(:arguments) { 'a = Foo::Bar' }
          it { is_expected.to eq 'a = Foo::Bar' }
        end

        context 'when multiple constant with a leading ::' do
          let(:arguments) { 'a = ::Foo::Bar' }
          it { is_expected.to eq 'a = ::Foo::Bar' }
        end
      end

      # TODO: I know that ["1", 2] is breaking
      context 'of a populated array' do
        let(:arguments) { 'a = [1, 2]' }
        it { is_expected.to eq 'a = [1, 2]' }
      end

      context 'of an empty hash' do
        let(:arguments) { 'a = {}' }
        it { is_expected.to eq 'a = {}' }
      end
    end

    # I'd never come across this syntax before
    context 'when using (*, max_identifier_length: 63, **)' do
      let(:arguments) { '*, max_identifier_length: 63, **' }
      it { is_expected.to eq '*, max_identifier_length: = 63, **' }
    end

    context 'when it has multiple arguments' do
      let(:arguments) { 'a,b,c' }
      it { is_expected.to eq 'a, b, c' }
    end
  end
end
