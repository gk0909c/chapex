require 'strscan'

module Chapex
  # Tokenize input string to consume it with racc
  class Lexer
    attr_reader :tokens

    def initialize
      @tokens = []
    end

    def tokenize(str)
      scanner = StringScanner.new(str)

      scan(scanner, :IDENT, /class\s/)
      scan(scanner, :CLASS_NAME, /[A-Za-z0-9_]*/)
      scan(scanner, :LEFT_CB, /\s*{/)

      scan_var(scanner) until scanner.check(/^\s*}\s*/m)
    end

    def next
      @tokens.shift
    end

    private

    def scan_var(scanner)
      scan(scanner, :IDENT, /\s*(public\s+)?\w+\s+/)
      scan(scanner, :VAR_NAME, /\w+/)
      scan(scanner, :SEMI, /\s*;/)
    end

    def scan(scanner, type, regex)
      scanner.scan(/\n/)
      @tokens.push([type, scanner.matched]) if scanner.scan(regex)
    end
  end
end
