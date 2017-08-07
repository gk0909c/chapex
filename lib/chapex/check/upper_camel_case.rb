module Chapex
  module Check
    # check upper camel case
    class UpperCamelCase < Base
      MSG = 'field name should start with Lower case: %s'.freeze

      def on_field(val)
        add_warning(MSG % val[1]) unless val[1][0] =~ /[a-z]/
      end
    end
  end
end
