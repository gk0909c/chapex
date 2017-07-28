module Chapex
  class Lexer
    attr_reader :tokens

    def initialize
      @tokens = []
    end

    def tokenize(str)
      cls_def = str.match(/^(class\s[A-Z][A-Za-z0-9_]*\s{)(.*)(})/m)
      @tokens.push([:CLASS_DEF, cls_def[1]])
      cls_body = cls_def[2]
      vars = cls_body.scan(/public\s.+;/)
      vars.each { |v| @tokens.push([:VARIABLE_DEF, v]) }
    end
  end
end
