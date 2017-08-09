require 'strscan'

module Chapex
  # Tokenize input string to consume it with racc
  class Lexer
    attr_reader :tokens

    def initialize(str)
      @tokens = []
      @scanner = StringScanner.new(str)
    end

    def tokenize
      scan(:IDENT, /class\s/)
      scan(:CLASS_NAME, /[A-Za-z0-9_]*/)
      scan(:LEFT_CB, /\s*{/)

      scan_var until @scanner.check(/^\s*}\s*/m)
    end

    private

    def scan_var
      scan(:IDENT, /\s*(public\s+)?\w+\s+/)
      scan(:FIELD_NAME, /\w+/)
      scan(:SEMI, /\s*;/)
    end

    def scan(type, regex)
      @scanner.scan(/\n/)
      @tokens.push([type, @scanner.matched]) if @scanner.scan(regex)
    end
  end
end
