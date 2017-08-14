module Chapex
  module Ast
    # AST builder
    class Builder
      NODE_TYPES = %i[
        apex_class class_dec class_body field method
      ].freeze

      NODE_TYPES.each do |t|
        define_method(t) do |arg|
          node(t, arg)
        end
      end

      def initialize(source)
        @source = source
      end

      def edge_node(type, token)
        children = token ? [token.value] : []
        props = edge_node_props(token)

        node(type, children, props)
      end

      private

      def node(type, children, props = {})
        Chapex::Ast::Node.new(type, children, props)
      end

      def edge_node_props(token)
        return {} unless token

        props = token.range_hash
        row, column = @source.position(token.token_start)
        props[:row] = row
        props[:column] = column
        props
      end
    end
  end
end
