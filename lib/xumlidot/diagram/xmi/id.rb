# frozen_string_literal: true

require 'securerandom'

module Xumlidot
  class Diagram
    class Xmi
      # Helper - everything needs an id and these ids need to be used in the
      # Element section
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
end
