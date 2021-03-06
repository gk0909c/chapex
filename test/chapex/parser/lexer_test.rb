require 'test_helper'

class LexerTest < Minitest::Test
  def test_tokenize
    source = Chapex::Source.new("#{Dir.pwd}/test/fixtures/Valid.cls")

    expects = [
      [:SCOPE, 'public', 0, 5],
      [:ABSTRACT, 'abstract', 7, 14],
      [:CLASS, 'class', 16, 20],
      [:IDENT, 'Leo', 22, 24],
      [:L_CB, '{', 26, 26],
      [:SCOPE, 'public', 32, 37],
      [:FINAL, 'final', 39, 43],
      [:STATIC, 'static', 45, 50],
      [:IDENT, 'String', 52, 57],
      [:IDENT, 'CO_V', 59, 62],
      [:SEMI, ';', 63, 63],
      [:SCOPE, 'private'],
      [:IDENT, 'String'],
      [:IDENT, 'str2'],
      [:SEMI, ';'],
      [:IDENT, 'Integer'],
      [:IDENT, 'int1'],
      [:SEMI, ';'],
      [:SCOPE, 'private'],
      [:IDENT, 'Integer'],
      [:IDENT, 'int2'],
      [:EQUAL, '='],
      [:N_LITERAL, '3'],
      [:SEMI, ';'],
      [:SCOPE, 'public'],
      [:IDENT, 'void'],
      [:IDENT, 'getMethod'],
      [:L_RB, '('],
      [:R_RB, ')'],
      [:L_CB, '{'],
      [:IDENT, 'String'],
      [:IDENT, 'mes'],
      [:EQUAL, '='],
      [:S_LITERAL, "'abc'"],
      [:SEMI, ';'],
      [:IDENT, 'System'],
      [:DOT, '.'],
      [:IDENT, 'debug'],
      [:L_RB, '('],
      [:IDENT, 'mes'],
      [:R_RB, ')'],
      [:SEMI, ';'],
      [:IDENT, 'str2'],
      [:EQUAL, '='],
      [:IDENT, 'mes'],
      [:SEMI, ';'],
      [:IDENT, 'System'],
      [:DOT, '.'],
      [:IDENT, 'debug'],
      [:L_RB, '('],
      [:IDENT, 'str2'],
      [:R_RB, ')'],
      [:SEMI, ';'],
      [:R_CB, '}'],
      [:R_CB, '}']
    ]

    lexer = Chapex::Parser::Lexer.new(source.string)
    lexer.tokenize
    tokens = lexer.tokens

    assert_equal(55, tokens.length)
    tokens.each_with_index do |t, i|
      e = expects[i]
      check_token(t, e[0], e[1], e[2], e[3])
    end
  end

  def test_keyword_token
    source = 'public virtual class Klass'
    lexer = Chapex::Parser::Lexer.new(source)
    lexer.tokenize
    tokens = lexer.tokens

    assert_equal(:SCOPE, tokens[0][0])
    assert_equal(:VIRTUAL, tokens[1][0])
    assert_equal(:CLASS, tokens[2][0])
    assert_equal(:IDENT, tokens[3][0])
  end

  private

  def check_token(token, type, value, t_s, t_e)
    assert_equal(type, token[0])
    assert_equal(value, token[1].value)
    # a little taking easy course
    assert_equal(t_s, token[1].token_start) if t_s
    assert_equal(t_e, token[1].token_end) if t_e
  end
end
