require 'securerandom'

module Xamin
  module Xmi
    module ID
      def id
        @_id ||= new_id
      end

      private 

      def new_id
        SecureRandom.hex
      end
    end
  end
end
