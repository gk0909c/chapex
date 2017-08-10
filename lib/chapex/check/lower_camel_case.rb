module Chapex
  module Check
    # check lower camel case
    class LowerCamelCase < Base
      MSG = 'field name should start with Lower case: %s'.freeze

      def on_field(val)
        field_name = val[2]
        add_warning(MSG % field_name) unless field_name =~ /^[a-z]\w*/
      end
    end
  end
end
