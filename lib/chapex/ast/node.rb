module Chapex
  module Ast
    # ast node
    class Node < AST::Node
      attr_reader :token_start, :token_end, :row, :column

      def value
        @children[0]
      end

      # get specified child node
      def [](idx)
        @children[idx]
      end

      def location
        Chapex::SourceLocation.new(row, column)
      end
    end
  end
end
