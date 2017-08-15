module Chapex
  module Check
    # check lower camel case
    class LowerCamelCase < Base
      MSG = 'field name should be lower camelcase: %s'.freeze

      def on_field(nodes)
        field_name = nodes[2].value
        add_violation(MSG % field_name, nodes[2]) unless field_name =~ /^[a-z]\w*/
      end
    end
  end
end
