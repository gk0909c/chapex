require 'strscan'

module Chapex
  # Tokenize input string to consume it with racc
  class Lexer
    Lexicality = Struct.new(:expression, :token, :invoke)

    attr_reader :tokens

    SCOPE = /\b(public|protected|private|global)\b/

    EXPRESSIONS = [
      Lexicality.new(/\bclass\b/, :CLASS, :emit),
      Lexicality.new(SCOPE, :SCOPE, :emit),
      Lexicality.new(/\s*?{/, :LEFT_CB, :emit),
      Lexicality.new(/\s*?;/, :SEMI, :emit),
      Lexicality.new(/\s*?}/, :RIGHT_CB, :emit),
      Lexicality.new(/\b\w+\b/, :IDENT, :emit),
      Lexicality.new(/\s+?/, nil, :nothing)
    ].freeze

    def initialize(str)
      @tokens = []
      @scanner = StringScanner.new(str)
    end

    def tokenize
      until @scanner.eos?
        EXPRESSIONS.each do |lex|
          next if skip?(lex)
          send(lex.invoke, lex.token, @scanner.matched)
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

    def emit(type, chars)
      @tokens.push([type, chars])
    end
  end
end
