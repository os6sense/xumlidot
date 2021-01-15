# frozen_string_literal: true

require_relative '../parsers'
require_relative '../types'

module Xumlidot
  module Parsers
    # Save current visibility and restore it after processing
    module Scope
      # Maintains current state of method visability
      class Visibility
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

      def public(&_block)
        temp_visibility = get_visibility
        set_visibility
        yield if block_given?
        set_visibility(temp_visibility)
      end

      def set_visibility(state = :public)
        Visibility.send(state)
      end

      def get_visibility
        Visibility.state
      end

      module_function :set_visibility
      module_function :get_visibility
      module_function :public
    end
  end
end
