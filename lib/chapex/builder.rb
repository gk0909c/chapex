module Chapex
  # AST builder
  class Builder
    def var_name(name)
      AST::Node.new(name.to_sym, [], :var_name => name)
    end
  end
end
