module Chapex
  module Parser
    # Tokenize input string to consume it with racc
    class Lexer
      Lexicality = Struct.new(:expression, :token, :invoke)

      attr_reader :tokens

      SCOPE = /\b(public|protected|private|global)\b/
      KEYWORDS = %i[
        virtual
        abstract
        class
        implements
        extends
        final
        override
        static
        if
        else
        true
        false
        for
        do
        while
      ].freeze
      KEYWORD = /\b(#{KEYWORDS.join('|')})\b/
      SHARING = /\b(with|without)\b\s\bsharing\b/

      EXPRESSIONS = [
        Lexicality.new(SCOPE, :SCOPE, :emit),
        Lexicality.new(KEYWORD, :KEYWORD, :emit_keyword),
        Lexicality.new(SHARING, :SHARING, :emit),
        Lexicality.new(/{/, :L_CB, :emit),
        Lexicality.new(/}/, :R_CB, :emit),
        Lexicality.new(/\(/, :L_RB, :emit),
        Lexicality.new(/\)/, :R_RB, :emit),
        Lexicality.new(/\./, :DOT, :emit),
        Lexicality.new(/,/, :COMMA, :emit),
        Lexicality.new(/==/, :DBL_EQUAL, :emit),
        Lexicality.new(/<=/, :GREATER_EQUAL, :emit),
        Lexicality.new(/</, :GREATER, :emit),
        Lexicality.new(/>=/, :LESS_EQUAL, :emit),
        Lexicality.new(/>/, :LESS, :emit),
        Lexicality.new(/=/, :EQUAL, :emit),
        Lexicality.new(/;/, :SEMI, :emit),
        Lexicality.new(/:/, :COLON, :emit),
        Lexicality.new(/\+\+/, :INCREAMENT, :emit),
        Lexicality.new(/--/, :DECREAMENT, :emit),
        Lexicality.new(/\+/, :PLUS, :emit),
        Lexicality.new(/-/, :MINUS, :emit),
        Lexicality.new(/\*/, :MULTIPLY, :emit),
        Lexicality.new(%r{\/}, :DIVIDE, :emit),
        Lexicality.new(/%/, :REMAINDER, :emit),
        Lexicality.new(/'.*?'/, :S_LITERAL, :emit),
        Lexicality.new(/[0-9]+/, :N_LITERAL, :emit),
        Lexicality.new(/\b\w+\b/, :IDENT, :emit),
        Lexicality.new(/\[.+?\]/m, :SOQL, :emit),
        Lexicality.new(/\s+?/)
      ].freeze

      def initialize(str)
        @tokens = []
        @scanner = StringScanner.new(str)
      end

      def tokenize
        until @scanner.eos?
          EXPRESSIONS.each do |lex|
            @scanner.scan(lex.expression)
            next if skip?(lex)
            add_token(lex)
            break
          end
        end
      end

      private

      def skip?(lex)
        return true unless @scanner.matched
        return true if lex.token.nil?
        false
      end

      def add_token(lex)
        send(lex.invoke, lex.token)
      end

      def emit(type)
        token = [type, token_value]
        @tokens.push(token)
      end

      def emit_keyword(_)
        token = [matched_to_type, token_value]
        @tokens.push(token)
      end

      def token_value
        TokenValue.new(
          @scanner.matched,
          @scanner.pointer - @scanner.matched_size,
          @scanner.pointer - 1
        )
      end

      def matched_to_type
        @scanner.matched.upcase.to_sym
      end
    end
  end
end
