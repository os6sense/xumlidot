require_relative 'directory_tree'
require_relative 'parsers'
require_relative 'diagram'

# TODO: user input
directories = [ARGV[0]]

dt = Xumlidot::DirectoryTree.new(directories)

# THis is our tree of klasses/modules etc
constants = ::Xumlidot::Parsers::Stack::Constants.new

dt.find_all_rb_files do |path|
  STDERR.puts path
  file_contents = File.read(path)

  @parser = Xumlidot::Parsers::File.new(file_contents, constants)
  @parser.parse
end

#resolve inheritance tree
# If a class is inherited from but does not exist in the constants
# we will create a dummy class.
#
# if a class is inherited from, we want to find it using the constant lookup
# rules definind in the resolver
#
# and what ... we want to add a reference too it?
#
# This REALLY should be done whenever we add a superklass
# i.e. yeah, its a hack
constants.resolve_inheritance()

diagram = ::Xumlidot::Diagram.new(constants, :Dot)
diagram.draw
