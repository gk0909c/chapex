module Chapex
  module Ast
    # ast node
    class Node < AST::Node
      attr_reader :token_start, :token_end, :row, :column

      def initialize(type, children = [], props = {})
        @mutable_props = {}
        super
      end

      # expected this node to have only one child.
      # and the class is primitive like String, Fixnum.
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

      # get first child, the first child need to have row and column.
      def first_child
        @mutable_props[:first_child] ||= @children.find do |c|
          c.instance_of?(self.class) && c.located?
        end
        @mutable_props[:first_child]
      end

      def parent
        @mutable_props[:parent]
      end

      def parent=(node)
        @mutable_props[:parent] = node
      end

      def located_parent
        p = @mutable_props[:parent]
        return p if p.located?
        p.located_parent
      end

      protected

      def located?
        @row && @column
      end
    end
  end
end
