require 'ast'

module Chapex
  module Ast
    # ast node
    class Node < AST::Node
      attr_reader :pointer
    end
  end
end
