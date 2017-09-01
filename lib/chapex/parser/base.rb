module Chapex
  module Parser
    # Apex Code Parser
    class Base < Racc::Parser
      def initialize(source)
        @source = source
        @lexer = Lexer.new(source.string)
        @builder = Chapex::Ast::Builder.new(source)

        @yydebug = true
      end

      def parse
        @lexer.tokenize
        @tokens = @lexer.tokens
        @source.ast = do_parse
      end

      def next_token
        @tokens.shift
      end

      def on_error(error_token_id, error_value, value_stack)
        row, column = @source.position(error_value.token_start)
        puts "skip error '#{error_value.value}' at #{row}:#{column}"
      end
    end
  end
end
