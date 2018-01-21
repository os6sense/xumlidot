require_relative 'directory_tree'
require_relative 'parsers'
require_relative 'graph/tree'

# TODO: user input
directories = [ARGV[0]]

dt = Xamin::DirectoryTree.new(directories)
constants = ::Xamin::Parsers::Stack::Constants.new

dt.find_all_rb_files do |path|
  STDERR.puts path
  file_contents = File.read(path)

  @parser = Xamin::Parsers::File.new(file_contents, constants)
  @parser.parse
end

class RubyResolver # Will govern how namespace lookup works
end

#resolve inheritance tree
# If a class is inherited from but does not exist in the constants
# we will create a dummy class.
#
# if a class is inherited from, we want to find it using the constant lookup
# rules definind in the resolver
#
# and what ... we want to add a reference too it?
constants.resolve_inheritance(RubyResolver.new)

binding.pry
graph = Xamin::Tree.new

graph.to_xmi
#graph.to_dot
