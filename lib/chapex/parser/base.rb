require 'racc/parser'
require 'chapex/parser/lexer'
require 'chapex/ast/builder'

module Chapex
  module Parser
    # Apex Code Parser
    class Base < Racc::Parser
      def initialize(source, lexer = Lexer, builder = Chapex::Ast::Builder)
        @source = source
        @builder = builder.send(:new, source)
        @lexer = lexer.send(:new, source.string)
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
