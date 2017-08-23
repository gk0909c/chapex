module Chapex
  module Check
    # concerns about class field
    module FieldConcern
      def const_field?(node)
        node.has?(:static) && node.has?(:final)
      end

      private :const_field?
    end
  end
end
