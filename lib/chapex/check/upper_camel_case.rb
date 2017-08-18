module Chapex
  module Check
    # check lower camel case
    class UpperCamelCase < Base
      MSG = 'class name "%s" should be upper camelcase'.freeze

      def on_class_dec(node)
        check_node = node[2]
        class_name = check_node.value
        return if class_name =~ /^[A-Z]\w*/

        add_violation(check_node.location, class_name)
      end
    end
  end
end
