require 'chapex/parser/apex'

module Chapex
  # source expression. string, ast, line array
  class Source
    attr_reader :s_expression
    attr_accessor :ast

    def initialize(filepath)
      @s_expression = File.read(filepath)
      @ast = nil
    end

    def parse_ast
      parser = Chapex::Parser::Apex.new(@source_str)
      @ast = parser.parse
    end
  end
end
