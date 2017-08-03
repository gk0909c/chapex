require 'racc/parser'
require 'chapex/lexer'
require 'chapex/checker'

module Chapex
  module Parser
    # Apex Code Parser
    class Base < Racc::Parser
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
end
