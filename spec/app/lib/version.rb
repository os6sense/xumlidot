# frozen_string_literal: true

module VersionModule
  def self.gem_version
    Gem::Version.new VERSION::STRING
  end

  class Version
    # bug/missing feature, constants not defined
    MAJOR = 0
    MINOR = 2
    TINY  = 0
    PRE   = 'alpha'

    # BUG - this ends up as being a superclass, it should just be a constant called STRING
    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')
  end
end
