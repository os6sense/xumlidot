require_relative 'directory_tree'
require_relative 'parsers'

# TODO: user input
directories = [ARGV[0]]

tree = Xamin::DirectoryTree.new(directories)
tree.find_all_rb_files do |path|
  puts path
  file_contents = File.read(path)

  parser = Xamin::Parsers::File.new(file_contents)
  parser.parse
end
