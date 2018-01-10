require 'spec_helper'

describe ::Xamin::Parsers::Args do

  let(:parsed) { RubyParser.new.parse(code) }
  subject { described_class.new(parsed).to_s }

  context 'when passed an s expression' do
    context 'when it has a single argument' do
      let(:code) { 'def method(a, b); end' }
      it { is_expected.to eq 'a, b' }

    end
  end
end
