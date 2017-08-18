module Chapex
  module Ast
    # ast node
    class Node < AST::Node
      attr_reader :token_start, :token_end, :row, :column

      def initialize(type, children = [], props = {})
        @mutable_props = {}
        children.each do |c|
          c.parent = self if c.is_a?(self.class)
        end

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

      def first_child_location
        first_child.location
      end

      def parent
        @mutable_props[:parent]
      end

      def parent=(node)
        @mutable_props[:parent] = node
      end

      def grand_parent_location
        parent.parent.first_child.location
      end

      protected

      def located?
        @row && @column
      end
    end
  end
end
