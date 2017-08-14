require 'ast'

module Chapex
  module Ast
    # ast node
    class Node < AST::Node
      attr_reader :token_start, :token_end, :row, :column

      def token_value
        @children[0]
      end
    end
  end
end
