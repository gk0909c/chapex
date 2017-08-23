module Chapex
  module Check
    module Naming
      # check lower camel case
      class UpperSnakeCase < Base
        include FieldConcern

        MSG = 'constant field name "%s" should be upper snake case'.freeze

        def on_field(node)
          return unless const_field?(node)
          check_name_pattern(node, /^[A-Z][A-Z0-9_]*/)
        end
      end
    end
  end
end
