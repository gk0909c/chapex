module Chapex
  module Check
    module Naming
      # check lower camel case
      class LowerCamelCase < Base
        MSG = 'field name "%s" should be lower camelcase'.freeze

        def on_field(node)
          check_node = node.find(:name)
          field_name = check_node.value
          return if field_name =~ /^[a-z]\w*/
          return if const_field?(node)

          add_violation(check_node.location, field_name)
        end

        private

        def const_field?(node)
          node.has(:static) && node.has(:final)
        end
      end
    end
  end
end
