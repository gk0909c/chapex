module Chapex
  module Check
    # check indentation width
    class IndentationWidth < Base
      W = 4
      MSG = 'expected indentation is %d, but %d'.freeze

      # compare with parent parent node whose position is first child's position
      def on_stmt(node)
        own_loc = node.first_child_location
        base_loc = node.grand_parent_location

        expected_column = base_loc.column + W
        diff = own_loc.column - expected_column

        return if diff.zero?

        add_violation(
          own_loc,
          base_loc.column + W,
          own_loc.column
        )
      end
      alias on_method :on_stmt
      alias on_field :on_stmt
    end
  end
end
