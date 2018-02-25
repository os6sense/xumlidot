require 'find'

module Xumlidot
  # Recurse down a directory tree
  class DirectoryTree
    def initialize(directories, options)
      @directories = directories
      @options = options
      @excluded = Regexp.new(@options.exclude)
    end

    def find_all_rb_files(&block)
      @directories.each do |directory|

        Find.find(directory) do |path|
          next if path =~ @exluded

          next unless path.end_with? '.rb'

          yield path if block_given?
        end
      end
    end
  end
end
