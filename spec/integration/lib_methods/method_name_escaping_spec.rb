# frozen_string_literal: true

require 'spec_helper'

describe 'Output of lib/methods' do
  let(:directory) { 'spec/app/lib/methods/' }

  let(:expect_dot) { Pathname.new(__dir__).join('method_name_escaping.dot').read }
  let(:expect_xmi) { Pathname.new(__dir__).join('method_name_escaping.xmi').read }

  specify { expect { generate_dot(directory) }.to output(expect_dot).to_stdout }
  specify { expect { generate_xmi(directory) }.to output(expect_xmi).to_stdout }
end
