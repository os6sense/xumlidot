require_relative '../parsers'

module Xamin
  module Parsers

    # Save current visibility and restore it after processing
    module Scope
      def public(&block)
        temp_visibility = get_visibility
        set_visibility
        yield if block_given?
        set_visibility(temp_visibility)
      end
      module_function :public

      def set_visibility(state = :public)
        ::Xamin::Parsers::MethodSignature::Visibility.send(state)
      end
      module_function :set_visibility

      def get_visibility
        ::Xamin::Parsers::MethodSignature::Visibility.state
      end
      module_function :get_visibility
    end

  end
end
