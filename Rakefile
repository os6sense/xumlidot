require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "xamin"
    gem.executables = "xamin"
    gem.email = ['brian@trnsfr.com']
    gem.homepage = "http://github.com/drboolean/xamin"
    gem.authors = ["Brian Lonsdorf"]
    gem.summary = "A xmi generator for Ruby on Rails applications"
    gem.description = gem.summary
    gem.files = FileList["[A-Z]*", "{autotest,bin,lib,spec}/**/*", ".document"]
    gem.extra_rdoc_files = FileList["*.rdoc"]
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end

rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rake/rdoctask'
require 'bin/xamin'
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "xamin #{APP_VERSION}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
