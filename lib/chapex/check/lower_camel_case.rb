module Chapex
  module Check
    # check lower camel case
    class LowerCamelCase < Base
      MSG = 'field name should start with Lower case: %s'.freeze

      def on_field(nodes)
        field_name = nodes[2].value
        add_warning(MSG % field_name) unless field_name =~ /^[a-z]\w*/
      end
    end
  end
end
