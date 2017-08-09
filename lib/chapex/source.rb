require 'chapex/parser/apex'

module Chapex
  # source expression. string, ast, line array
  class Source
    attr_reader :ast

    def initialize(source_str)
      @source_str = source_str
    end

    def parse_ast
      parser = Chapex::Parser::Apex.new(@source_str)
      @ast = parser.parse
    end
  end
end
