module Chapex
  module Check
    module Naming
      # check lower camel case
      class UpperSnakeCase < Base
        include FieldConcern

        MSG = 'constant field name "%s" should be upper snake case'.freeze

        def on_field(node)
          return unless const_field?(node)
          check_node = node.find(:name)
          field_name = check_node.value
          return if field_name =~ /^[A-Z][A-Z0-9_]*/

          add_violation(check_node.location, field_name)
        end
      end
    end
  end
end
