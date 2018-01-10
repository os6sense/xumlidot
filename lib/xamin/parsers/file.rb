require 'sexp_processor'
require 'ruby_parser'
require 'pry'

require_relative 'args'
require_relative 'klass'

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

      # Maintains current state of a methods visability
      class CurrentMethodVisibility
        class << self

          def state
            @state ||= :public
          end

          def public
            @state = :public
          end

          def protected
            @state = :protected
          end

          def private
            @state = :private
          end
        end
      end

      def initialize(file_contents)
        @parsed_file = RubyParser.new.parse(file_contents)

        super()
      end

      def parse
        process(@parsed_file)
      end

      def process_sclass(exp)
        super do
          CurrentMethodVisibility.public
          puts "SCLASS: #{self.klass_name} INHERITS_FROM: "
          process_until_empty(exp)
        end
      rescue Exception => e
        exp
      end

      def process_class(exp)
        # Parses the class name and inheritance
        k = ::Xamin::Parsers::Klass.new(exp.dup[0..2], @class_stack).to_s
        puts "CLASS: #{k} "

        CurrentMethodVisibility.public
        super do
          process_until_empty(exp)
        end
      rescue Exception => e
        #binding.pry
        exp
      end

      def process_module(exp)
        super do
          CurrentMethodVisibility.public
          #puts "MODULE: #{self.klass_name}"
          process_until_empty(exp)
        end
      rescue Exception => e
        exp
      end

      def process_defn(exp)
        super do
          args = exp.shift
          temp = Args.new(args).to_s
          #puts "METHOD  #{CurrentMethodVisibility.state} #{self.method_name} #{temp}"
          process_until_empty(exp)
        end
      rescue Exception => e
        puts e
        exp
      end

      def process_defs(exp)
        super do
          #puts "CLASS METHOD #{self.method_name}"
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

        case name
        when :private
          CurrentMethodVisibility.private
        when :public
          CurrentMethodVisibility.public
        when :protected
          CurrentMethodVisibility.protected
        else
          #puts "CALL RECV:#{recv unless recv.nil? || recv.empty?} NAME:#{name} ARGS:#{args unless args.nil? || args.empty?}"
        end
        return exp
      rescue Exception => e
        exp
      end
    end
  end
end
