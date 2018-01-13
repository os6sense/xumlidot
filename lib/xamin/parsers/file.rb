require 'sexp_processor'
require 'ruby_parser'
require 'pry'

require_relative '../types'
require_relative '../parsers'

module Xamin
  module Parsers
    # THE HARD PARTS
    #
    # FOR CLASS DIAGRAM
    # - Inheritance is ignored need to parse and attach (for the graph)
    #
    # - need to identify if methods are public/private/protected: DONE
    #
    # - need to keep a track of the types of variables to that we know
    #   what the receivers class is i.e. uses.
    #
    # - Parse arguments: DONE (partially)

    # Takes a file contents (as a string) and parses it into
    # s expressions using ruby parser. The parse method uses
    # the SexpProcessors methods to contert to a graph
    class File < MethodBasedSexpProcessor

      def initialize(file_contents)
        @parsed_file = RubyParser.new.parse(file_contents)
        super()
      end

      def parse
        process(@parsed_file)
      end

      def process_sclass(exp)
        set_visibility
        puts ::Xamin::Parsers::Klass.new(exp.dup[0..2], @class_stack).to_s
        super { process_until_empty(exp) }
      rescue Exception => e
        puts "ERROR (#parse) #{e.message}"
        exp
      end

      def process_module(exp)
        set_visibility
        super do
          #puts "MODULE: #{self.klass_name}"
          process_until_empty(exp)
        end
      rescue Exception => e
        puts "ERROR (#process_module) #{e.message}"
        exp
      end

      def process_class(exp)
        set_visibility
        puts ::Xamin::Parsers::Klass.new(exp.dup[0..2], @class_stack).to_s
        super { process_until_empty(exp) }
      rescue Exception => e
        puts "ERROR (#process_class) #{e.message}"
        exp
      end

      # METHODS
      def process_defn(exp)
        tmpexp = exp.dup
        puts ::Xamin::Parsers::Methods.new(exp).to_s
        super { process_until_empty(exp.shift) }
      rescue Exception => e
        puts "ERROR (#process_defn) #{e.message}"
        exp
      end

      def process_defs(exp)
        puts ::Xamin::Parsers::Methods.new(exp.dup[0..2], superclass_method: true).to_s
        super { process_until_empty(exp.shift) }
      rescue Exception => e
        puts "ERROR (#process_defs) #{e.message}"
        exp
      end

      # CALLS
      def process_call(exp)
        exp.shift # remove the :call

        recv = process(exp.shift) # recv
        name = exp.shift
        args = process(exp.shift) # args

        case name
        when :private, :public, :protected
          set_visibility(name)
        else
          #puts "CALL RECV:#{recv unless recv.nil? || recv.empty?} NAME:#{name} ARGS:#{args unless args.nil? || args.empty?}"
        end
        return exp
      rescue Exception => e
        puts "ERROR (#process_call) #{e.message}"
        exp
      end

      # PRIVATE
      def set_visibility(state = :public)
        ::Xamin::Parsers::Methods::Visibility.send(state)
      end

      def get_visibility
        ::Xamin::Parsers::Methods::Visibility.state
      end
    end
  end
end
