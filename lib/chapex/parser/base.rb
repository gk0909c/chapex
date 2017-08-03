require 'racc/parser'
require 'chapex/lexer'
require 'chapex/builder'
require 'chapex/checker'

module Chapex
  module Parser
    # Apex Code Parser
    class Base < Racc::Parser
      attr_reader :checker

      def initialize(lexer = Lexer.new, builder = Builder.new, checker = Checker.new)
        @vars = []
        @checker = checker
        @builder = builder
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
