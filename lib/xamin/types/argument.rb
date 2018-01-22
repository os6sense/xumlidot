# frozen_string_literal: true

require_relative '../types'

module Xamin
  module Types
    # Value object for the actual argument
    #
    # Depending on the argument type, assign and default
    # may be unpopulated e.g.
    #
    #    def foo(a, b)
    #
    # will be parsed with an empty assign and default
    #
    #    def bar(a, b = nil)
    #
    # will have an assign of '=' and a default of nil
    #
    # Note that in Args, an assignment to a variable of nil
    # is parsed and the default value set to th symbol :nil
    class Argument
      #include ::Xamin::Xmi::Argument

      attr_accessor :assign, :default, :types
      attr_reader :name

      def initialize
        @types = []
      end

      def name=(val)
        @name = val.tr("&", '')
      end

      def to_s
        str_default = case default
                      when :nil
                        'nil'
                      when String
                        "\"#{default}\""
                      when NilClass
                        nil
                      when Symbol
                        ":#{default}"
                      else
                        default.to_s
                      end

        [@name, @assign, str_default ? str_default : nil ].compact.join(' ')
      end
    end
  end
end
