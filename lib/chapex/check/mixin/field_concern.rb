module Chapex
  module Check
    # concerns about class field
    module FieldConcern
      # check exist both child of node, :static and :final
      def const_field?(node)
        node.has?(:static) && node.has?(:final)
      end

      # check :name type child value is match specified regex.
      def check_name_pattern(node, regex)
        check_node = node.find(:name)
        field_name = check_node.value
        return if field_name =~ regex

        add_violation(check_node.location, field_name)
      end

      private :const_field?, :check_name_pattern
    end
  end
end
