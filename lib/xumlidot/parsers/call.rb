# frozen_string_literal: true

require_relative '../parsers'
require_relative '../types'

module Xumlidot
  module Parsers
    class Call < MethodBasedSexpProcessor
      attr_reader :definition

      def initialize(exp, klass)
        super()

        @klass = klass
        @modules = ::Xumlidot::Types::InheritedModule.new(nil)
        process(exp)
        return if klass.definition.nil?
        klass.definition.inherited_modules << @modules
      end

      def process_call(exp)
        exp.shift # remove the :call

        begin
        recv = process(exp.shift)
        rescue => e
          STDERR.puts " ** unable to calculate reciever for #{exp}"
        end

        name = exp.shift
        args = exp.shift

        case name
        when :private, :public, :protected
          ::Xumlidot::Parsers::Scope.set_visibility(name)
        when :include, :extend
          process(args)
        when :module_function
          # TODO: expose as an instance method on the module
        when :attr_reader
          add_attributes(args, exp, read: true)
        when :attr_writer
          add_attributes(args, exp, write: true)
        when :attr_accessor
          add_attributes(args, exp, read: true, write: true)
        # else
          # puts "CALL RECV:#{recv unless recv.nil? || recv.empty?} NAME:#{name} ARGS:#{args unless args.nil? || args.empty?}"
        end
        s()
      end

      def add_attributes(name, exp, read: false, write: false)
        @klass.attributes << ::Xumlidot::Types::Attribute.new(name.value, read, write)
        exp.each do |attribute|
          @klass.attributes << ::Xumlidot::Types::Attribute.new(attribute.value, read, write)
        end
      end

      def process_const(exp)
        # exp.shift # remove :const
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
