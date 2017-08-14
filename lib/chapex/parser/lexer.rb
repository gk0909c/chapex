require 'strscan'

module Chapex
  module Parser
    # Tokenize input string to consume it with racc
    class Lexer
      Lexicality = Struct.new(:expression, :token, :invoke)

      attr_reader :tokens

      SCOPE = /\b(public|protected|private|global)\b/

      EXPRESSIONS = [
        Lexicality.new(/\bclass\b/, :CLASS, :emit),
        Lexicality.new(SCOPE, :SCOPE, :emit),
        Lexicality.new(/{/, :L_CB, :emit),
        Lexicality.new(/}/, :R_CB, :emit),
        Lexicality.new(/\(/, :L_RB, :emit),
        Lexicality.new(/\)/, :R_RB, :emit),
        Lexicality.new(/\./, :DOT, :emit),
        Lexicality.new(/;/, :SEMI, :emit),
        Lexicality.new(/'.*?'/, :S_LITERAL, :emit),
        Lexicality.new(/\b\w+\b/, :IDENT, :emit),
        Lexicality.new(/\s+?/)
      ].freeze

      def initialize(str)
        @tokens = []
        @scanner = StringScanner.new(str)
      end

      def tokenize
        until @scanner.eos?
          EXPRESSIONS.each do |lex|
            next if skip?(lex)
            send(lex.invoke, lex.token)
            break
          end
        end
      end

      private

      def skip?(lex)
        return true unless @scanner.scan(lex.expression)
        return true if lex.token.nil?
        false
      end

      def emit(type)
        token_value = TokenValue.new(
          @scanner.matched,
          @scanner.pointer - @scanner.matched_size,
          @scanner.pointer - 1
        )
        token = [type, token_value]
        @tokens.push(token)
      end
    end
  end
end
