require_relative 'directory_tree'
require_relative 'parsers'
require_relative 'graph/tree'

# TODO: user input
directories = [ARGV[0]]

dt = Xamin::DirectoryTree.new(directories)
graph = Xamin::Tree.new

dt.find_all_rb_files do |path|
  puts path
  file_contents = File.read(path)

  parser = Xamin::Parsers::File.new(file_contents)
  parser.parse(graph)
end

graph.to_dot
