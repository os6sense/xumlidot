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
end

class Processor < MethodBasedSexpProcessor 
  def initialize(*args)
    super()
  end

  def process_class(exp)
    puts "CLASS: #{self.klass_name}"
    super
  end

  def process_module(exp)
    puts "MOUDLE: #{self.klass_name}"
    super
  end

  def process_defn(exp)
    puts "METHOD #{self.method_name}"
    super
  end

  def process_defs(exp)
    puts "SINGLETON METHOD #{self.method_name}"
    super
  end

  #def process_call(exp) 
    #recv = process(exp.shift)
    #name = exp.shift 
    #args = process(exp.shift) 
    #return exp
  #end 
end

# TODO: user input
directories = ['./app']

tree = Xamin::DirectoryTree.new(directories)
tree.find_all_rb_files do |path|
  puts path 
  file_contents = File.read(path)


  ruby_parsed = RubyParser.new.parse(file_contents)




  #ripped = Ripper.sexp(file_contents)[1][0]
  #pp ripped
  #s_exp = Sexp.from_array(ripped)
  #pp s_exp
  processor = Processor.new
  processor.process(ruby_parsed)
end
