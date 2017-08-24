module Chapex
  module Ast
    # AST builder
    class Builder
      NODE_TYPES = %i[
        program class_dec class_body field
        method method_args method_arg method_body
        stmts stmt if_stmt condition variable
      ].freeze

      NODE_TYPES.each do |t|
        define_method(t) do |children|
          node(t, children)
        end
      end

      def initialize(source)
        @source = source
      end

      # create terminal node.
      # @param type [Symbol] node type
      # @param token [Chapex::Parser::TokenValue] lexicalyzed token value
      # @return [Chapex::Ast::Node]
      def terminal_node(type, token)
        children = token ? [token.value] : []
        props = terminal_node_props(token)

        node(type, children, props)
      end

      # join nodes as one node
      # @param nodes [Array<Chapex::Parser::TokenValue, Chapex::Ast::Node>]
      # @return [Chapex::Ast::Node]
      def join_as_node(type, *nodes)
        s, e = extract_range(nodes)
        val = @source[s..e]
        terminal_node(type, Chapex::Parser::TokenValue.new(val, s, e))
      end

      private

      def joinable_type?(n)
        n.is_a?(Chapex::Ast::Node) || n.is_a?(Chapex::Parser::TokenValue)
      end

      def extract_range(nodes)
        starts = []
        ends = []

        nodes.each do |n|
          if joinable_type?(n)
            starts << n.token_start
            ends << n.token_end
          end
        end

        [starts.min, ends.max]
      end

      def node(type, children, props = {})
        Chapex::Ast::Node.new(type, children, props)
      end

      def terminal_node_props(token)
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
