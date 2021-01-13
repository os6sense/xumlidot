# frozen_string_literal: true

require_relative '../types'

module Xumlidot
  module Types
    # Value object for an argument as specified within a methods definition.
    #
    # e.g. def foo(a, b)
    #
    # a and b are the arguments
    #
    # Depending on the argument; type (TODO), assign and default may be
    # unpopulated e.g.
    #
    #    def foo(a, b)
    #
    # will be parsed with an empty assign and default, whereas
    #
    #    def bar(a = 1, b = nil)
    #
    # will both have an assign of '=' and defaults of 1 and :nil respectively.
    #
    # This is :nil rather than nill since an assignment to a variable of nil
    # is parsed in Args and the default value set to the *symbol* :nil
    class Argument
      attr_accessor :assign,
                    :default
      # :types # TODO: determine the type of the argument

      attr_reader :name

      def initialize
        # @types = []
      end

      def name=(val)
        @name = val.tr('&', '')
      end

      def to_s
        str_default = case default
                      when :nil
                        'nil'
                      when String
                        default
                      when NilClass
                        nil
                      when Symbol
                        ":#{default}"
                      when Hash
                        '{}' # TODO: Some hashes were crashing the parser, why?
                      else
                        default.to_s
                      end

        [@name, @assign, str_default || nil].compact.join(' ')
      end
    end
  end
end
