# frozen_string_literal: true

require_relative '../lib/xumlidot'

# Helpers, pass in the full directory path in order to
# generate xmi/dot output
def generate_dot(directory)
  options = ::Xumlidot::Options.parse(['--dot'])
  directories = [directory]
  ::Xumlidot::Loader.new(directories, options).load
end

# Hmmm, for the to work for xmi we're going to have
# to make the id generation repeatable rather than random
def generate_xmi(directory)
  options = ::Xumlidot::Options.parse(['--xmi'])
  directories = [directory]
  ::Xumlidot::Loader.new(directories, options).load
end
