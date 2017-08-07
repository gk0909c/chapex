module Chapex
  # AST builder
  class Builder
    def apex_class(children)
      node(:apex_class, children)
    end

    def class_name(name)
      node(:class_name, [], :value => name)
    end

    def class_body(children)
      node(:class_body, children)
    end

    def var_name(name)
      node(:var_name, [name], :value => name)
    end

    private

    def node(type, children, props = {})
      AST::Node.new(type, children, props)
    end
  end
end
