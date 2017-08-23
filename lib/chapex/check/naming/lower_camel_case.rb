module Chapex
  module Check
    module Naming
      # check lower camel case
      class LowerCamelCase < Base
        include FieldConcern

        MSG = 'field name "%s" should be lower camelcase'.freeze

        def on_field(node)
          return if const_field?(node)
          check_name_pattern(node, /^[a-z]\w*/)
        end
      end
    end
  end
end
