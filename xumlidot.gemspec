Gem::Specification.new do |s|
  s.authors = ['Adrian Lee Jackson']
  s.date = "2018-03-02"
  s.default_executable = 'xumlidot'
  s.description = %()
  s.email = ['xumlidot@librely.com']
  s.executables = ['xumlidot']
  s.homepage = 'http://github.com/os6sense/xumlidot'
  s.license = 'MIT'
  s.name = 'xumlidot'
  s.summary = %(Generates DOT and XMI for Ruby and Rails UML Class Diagrams. )
  s.rubygems_version = '1.3.6'

  s.require_paths = %w[lib]
  s.files = Dir['lib/*.rb'] + Dir['bin/*']
  s.test_files = Dir['spec/*.rb']

  s.version = '1.0.0.pre'

  s.add_dependency 'ruby_parser'
  s.add_dependency 'sexp_processor'

  s.add_development_dependency 'pry'
  s.add_development_dependency 'pry-byebug'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'zeus'
end
