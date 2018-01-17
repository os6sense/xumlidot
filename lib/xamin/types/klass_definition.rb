require_relative '../xmi'

module Xamin
  module Types

    # representation for class information
    class KlassDefinition
      class Name < Array
        def to_xmi
          map do |constant|
            constant.to_xmi
          end.join
        end
      end

      class Superklass < Array
      end

      attr_accessor :name,
                    :namespace, # seem to be using this in coth 
                                # here and constant, one or the other
                    
                    :superklass # superklass or superklasses?

      def initialize
        @name = Name.new
        @superklass = Superklass.new 
      end

      def to_s
        "KLASS: #{@name.first} < #{@superklass.reverse} "
      end
    end
  end
end
