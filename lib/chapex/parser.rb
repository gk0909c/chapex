require 'racc/parser'
require 'chapex/lexer'
require 'chapex/checker'

module Chapex
  # Apex Code Parser
  class Parser < Racc::Parser
    attr_reader :checker

    def initialize(lexer = Lexer.new, checker = Checker.new)
      @vars = []
      @checker = checker
      @lexer = lexer
    end

    def parse(str)
      @lexer.tokenize(str)
      do_parse
    end

    def next_token
      @lexer.next
    end
  end
end
