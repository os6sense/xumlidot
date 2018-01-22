# frozen_string_literal: true

require_relative '../types'

module Xumlidot
  module Types
    # Container class
    class Arguments < Array
      def to_s
        each.map(&:to_s).join(', ')
      end
    end
  end
end
