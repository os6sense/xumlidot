# frozen_string_literal: true

module VersionModule
  def self.gem_version
    Gem::Version.new VERSION::STRING
  end

  class Version
    MAJOR = 0
    MINOR = 2
    TINY  = 0
    PRE   = 'alpha'

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')
  end
end
