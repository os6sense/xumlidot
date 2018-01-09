require 'find'

module Xamin
  # Recurse down a directory tree
  class DirectoryTree
    def initialize(directories)
      @directories = directories
    end

    def find_all_rb_files(&block)
      @directories.each do |directory|
        Find.find(directory) do |path|
          next unless path.end_with? '.rb'
          yield path if block_given?
        end
      end
    end
  end
end
