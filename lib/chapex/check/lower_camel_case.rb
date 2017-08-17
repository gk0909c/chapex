module Chapex
  module Check
    # check lower camel case
    class LowerCamelCase < Base
      MSG = 'field name "%s" should be lower camelcase'.freeze

      def on_field(node)
        check_node = node[2]
        field_name = check_node.value
        add_violation(check_node.location, field_name) unless field_name =~ /^[a-z]\w*/
      end
    end
  end
end
