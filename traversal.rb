require 'find' 
require 'ruby_parser'
require 'sexp_processor'
require 'pry'
require 'ripper'
require 'pp'



module Xamin
  # Recursed down the directory tree
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

  # THE HARD PARTS
  #
  # FOR CLASS DIAGRAM
  # - Inheritance is ignored need to parse and attach (for the graph)
  # - need to identify if methods are public/private/protected
  # - need to keep a track of the types of variables to that we know 
  #   what the receivers class is i.e. uses.

  




  # Takes a file contents (as a string) and parses it into 
  # s expressions using ruby parser. The parse method uses
  # the SexpProcessors methods to contert to a graph
  class Parser < MethodBasedSexpProcessor 
    def initialize(file_contents)
      @parsed_file = RubyParser.new.parse(file_contents)

      super()
    end

    def parse
      process(@parsed_file)
    end

    def in_klass(name)
      binding.pry
      a = super
      binding.pry
    end

    def process_sclass(exp)
      super do
        puts "SCLASS: #{self.klass_name} INHERITS_FROM: "
        process_until_empty(exp)
      end
    rescue Exception => e
      exp
    end

    def process_class(exp)
      super do
        binding.pry
        puts "CLASS: #{self.klass_name} INHERITS_FROM: "
        process_until_empty(exp)
      end
    rescue Exception => e
      exp
    end

    def process_module(exp)
      super do
        puts "MODULE: #{self.klass_name}"
        process_until_empty(exp)
      end
    rescue Exception => e
      exp
    end

    def process_defn(exp)
      super do
        puts "METHOD #{self.method_name}"
        process_until_empty(exp)
      end
    rescue Exception => e
      exp
    end

    def process_defs(exp)
      super do
        puts "CLASS METHOD #{self.method_name}"
        process_until_empty(exp)
      end
    rescue Exception => e
      exp
    end

    def process_call(exp) 
      exp.shift # remove the :call
      recv = process(exp.shift)
      name = exp.shift 
      args = process(exp.shift) 
      
      puts "CALL RECV:#{recv unless recv.nil? || recv.empty?} NAME:#{name} ARGS:#{args unless args.nil? || args.empty?}"
      return exp
    rescue Exception => e
      exp
    end 
  end
end

# TODO: user input
directories = ['./app']

tree = Xamin::DirectoryTree.new(directories)
tree.find_all_rb_files do |path|
  puts path 
  file_contents = File.read(path)

  parser = Xamin::Parser.new(file_contents)
  parser.parse
end
