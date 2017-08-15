require 'racc/parser'
require 'chapex/parser/lexer'
require 'chapex/ast/builder'

module Chapex
  module Parser
    # Apex Code Parser
    class Base < Racc::Parser
      def initialize(source)
        @source = source
        @lexer = Lexer.new(source.string)
        @builder = Chapex::Ast::Builder.new(source)
      end

      def parse
        @lexer.tokenize
        @tokens = @lexer.tokens
        @source.ast = do_parse
      end

      def next_token
        @tokens.shift
      end
    end
  end
end
