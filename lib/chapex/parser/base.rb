require 'racc/parser'
require 'chapex/parser/lexer'
require 'chapex/ast/builder'

module Chapex
  module Parser
    # Apex Code Parser
    class Base < Racc::Parser
      include Chapex::Ast::Builder

      def initialize(source)
        @source = source
        @lexer = Lexer.new(source.string)
      end

      def parse
        @lexer.tokenize
        @tokens = @lexer.tokens
        @source.ast = do_parse
      end

      def next_token
        @tokens.shift
      end

      private

      def position(token_start)
        @source.position(token_start)
      end
    end
  end
end
