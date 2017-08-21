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

          add_violation(check_node.location, field_name)
        end
      end
    end
  end
end
