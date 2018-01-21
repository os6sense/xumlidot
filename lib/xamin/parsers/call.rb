require 'sexp_processor'
require 'pry'

require_relative '../types'
require_relative '../parsers'

module Xamin
  module Parsers

    class Call < MethodBasedSexpProcessor

      attr_reader :definition

      def initialize(exp, klass)
        super()

        @modules = ::Xamin::Types::InheritedModule.new(nil)
        process(exp)
        klass.definition.inherited_modules << @modules
        @klass = klass
      end

      def process_call(exp)
        exp.shift # remove the :call

        recv = process(exp.shift) # recv
        name = exp.shift
        args = exp.shift

        case name
        when :private, :public, :protected
          ::Xamin::Parsers::Scope.set_visibility(name)
        when :include, :extend
          process(args)
        when :module_function
          # will make a method into a class method on the module
          # Find the method name and change it to a superklass one

        else
          #puts "CALL RECV:#{recv unless recv.nil? || recv.empty?} NAME:#{name} ARGS:#{args unless args.nil? || args.empty?}"
        end
        s()
      end

      def process_const(exp)
        #exp.shift # remove :const
        @modules << exp.value
        process_until_empty(exp)
        s()
      end

      def process_colon2(exp)
        exp.shift # remove :colon2
        @modules << exp.value
        process_until_empty(exp)
        s()
      end

      def process_colon3(exp)
        exp.shift # remove :colon3
        @modules << '::'
        @modules << exp.value
        process_until_empty(exp)
        s()
      end

    end
  end
end
