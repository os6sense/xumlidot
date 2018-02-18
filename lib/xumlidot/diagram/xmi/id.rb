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

        def force_id(id)
          @_id = id
        end

        def gen_id
          @gen_id ||= "#{new_id[0..5]}.#{new_id[0..5]}".upcase
        end

        def association_id
          @association_id ||= "#{new_id[0..5]}.#{new_id[0..5]}".upcase
        end

        def association_end_id
          @association_end_id ||= "#{new_id[0..5]}.#{new_id[0..5]}".upcase
        end

        private

        def new_id
          SecureRandom.hex
        end
      end
    end
  end
end
