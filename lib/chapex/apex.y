class Chapex::Apex
rule
  apex_class: class_def class_body
  class_def: CLASS_DEF { puts "meet cls-def with #{val[0]}" }
  class_body:
            | variable
  variable: VARIABLE_DEF { puts "meet var-def with #{val[0]}" }
          | variable VARIABLE_DEF { puts "meet var-def recursion with #{val[0]}" }
end

---- inner
  require 'chapex/lexer'

---- inner
  def initialize
  end

  def parse(str)
    lexer = Lexer.new
    lexer.tokenize(str)
    @c = lexer.tokens

    do_parse
  end

  def next_token
    @c.shift
  end

  def parsed_cls
    @parsed_cls
  end
---- footer

