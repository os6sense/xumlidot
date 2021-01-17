# frozen_string_literal: true

require 'spec_helper'

describe 'Output of lib/composition/class' do
  let(:directory) { 'spec/app/lib/composition/class' }

  let(:expect_dot) { File.open('spec/integration/lib_composition/class_composition.dot').read }
  let(:expect_xmi) { File.open('spec/integration/lib_composition/class_composition.xmi').read }

  specify { expect { generate_dot(directory) }.to output(expect_dot).to_stdout }
  specify { expect { generate_xmi(directory) }.to output(expect_xmi).to_stdout }
end
