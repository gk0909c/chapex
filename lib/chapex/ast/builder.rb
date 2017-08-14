module Chapex
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

    def edge_node(type, token)
      children = token ? [token.value] : []
      props = token ? token.range_hash : {}

      node(type, children, props)
    end

    private

    def node(type, children, props = {})
      Chapex::Ast::Node.new(type, children, props)
    end
  end
end
