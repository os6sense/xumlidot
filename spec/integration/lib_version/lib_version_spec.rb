# frozen_string_literal: true

require 'spec_helper'

describe 'Output of lib/version.rb' do
  let(:directory) { 'spec/app/lib/version' }
  # let(:expect_xmi) { File.open('spec/integration/lib_version/lib_version.xmi lib_version.xmi').read }
  let(:expect_dot) { File.read('spec/integration/lib_version/lib_version.dot') }

  specify { expect { generate_dot(directory) }.to output(expect_dot).to_stdout }

  # TODO: Make xmi output id repeatble ...
  # specify { expect { generate_xmi(directory) }.to output(expect_xmi).to_stdout }
end
