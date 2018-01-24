Gem::Specification.new do |s|

  s.name = %q{xumlidot}
  s.version = "0.0.1"

  #s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Adrian Lee Jackson"]
  s.date = %q{2018-01-26}
  s.default_executable = %q{xumlidot}
  s.description = %q{Generates DOT and XMI for Ruby and Rails.}
  s.email = ["xumlidot@librely.com"]
  s.executables = ["xumlidot"]

  s.files = Dir['lib/*.rb'] + Dir['bin/*']
  s.homepage = %q{http://github.com/drboolean/xamin}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}

  s.summary = %q{Generates DOT and XMI for Ruby and Rails.}

  s.test_files = Dir['spec/*.rb'] 

  #if s.respond_to? :specification_version then
    #current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    #s.specification_version = 2

    #if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    #else
    #end
  #else
  #end
end
