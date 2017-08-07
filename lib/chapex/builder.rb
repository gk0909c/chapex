module Chapex
  # AST builder
  class Builder
    def apex_class(children)
      node(:apex_class, children)
    end

    def class_dec(val)
      node(:class_dec, val)
    end

    def class_body(children)
      node(:class_body, children)
    end

    def field(val)
      node(:field, val)
    end

    private

    def node(type, children, props = {})
      AST::Node.new(type, children, props)
    end
  end
end
