# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{xamin}
  s.version = "0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brian Lonsdorf"]
  s.date = %q{2009-12-26}
  s.default_executable = %q{xamin}
  s.description = %q{An xmi generator for Ruby on Rail applications}
  s.email = ["brian@trnsfr.com"]
  s.executables = ["xamin"]
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = [
     "README.rdoc",
     "Rakefile",
     "bin/xamin",
     "lib/diagram.rb",
     "lib/association.rb",
     "lib/attribute.rb",
     "lib/method.rb",
     "lib/model.rb",
     "spec/xamin_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.has_rdoc = false
  s.homepage = %q{http://github.com/drboolean/xamin}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{An xmi generator for Ruby on Rail applications}
  s.test_files = [
    "spec/spec_helper.rb",
    "spec/xamin_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
