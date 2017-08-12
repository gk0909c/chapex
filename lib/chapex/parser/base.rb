require 'racc/parser'
require 'chapex/parser/lexer'
require 'chapex/ast/builder'

module Chapex
  module Parser
    # Apex Code Parser
    class Base < Racc::Parser
      def initialize(str, lexer = Lexer.new(str), builder = Builder.new)
        @builder = builder
        @lexer = lexer
      end

      def parse
        @lexer.tokenize
        @tokens = @lexer.tokens
        do_parse
      end

      def next_token
        @tokens.shift
      end
    end
  end
end
