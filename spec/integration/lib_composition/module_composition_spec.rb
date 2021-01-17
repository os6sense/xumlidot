# frozen_string_literal: true

require 'spec_helper'

describe 'Output of lib/composition/module' do
  let(:directory) { 'spec/app/lib/composition/module' }

  let(:expect_dot) { File.open('spec/integration/lib_composition/module_composition.dot').read }
  let(:expect_xmi) { File.open('spec/integration/lib_composition/module_composition.xmi').read }

  specify { expect { generate_dot(directory) }.to output(expect_dot).to_stdout }
  specify { expect { generate_xmi(directory) }.to output(expect_xmi).to_stdout }
end
