require 'test_helper'

class LexerTest < Minitest::Test
  def test_tokenize
    source = Chapex::Source.new("#{Dir.pwd}/test/fixtures/Valid.cls")

    expects = [
      [:SCOPE, 'public', 0, 5],
      [:CLASS, 'class', 7, 11],
      [:IDENT, 'Leo', 13, 15],
      [:L_CB, '{', 17, 17],
      [:SCOPE, 'public', 23, 28],
      [:IDENT, 'String', 30, 35],
      [:IDENT, 'str1', 37, 40],
      [:SEMI, ';', 41, 41],
      [:SCOPE, 'private'],
      [:IDENT, 'String'],
      [:IDENT, 'str2'],
      [:SEMI, ';'],
      [:IDENT, 'Integer'],
      [:IDENT, 'int1'],
      [:SEMI, ';'],
      [:SCOPE, 'public'],
      [:IDENT, 'void'],
      [:IDENT, 'getMethod'],
      [:L_RB, '('],
      [:R_RB, ')'],
      [:L_CB, '{'],
      [:IDENT, 'System'],
      [:DOT, '.'],
      [:IDENT, 'debug'],
      [:L_RB, '('],
      [:S_LITERAL, "'test message'"],
      [:R_RB, ')'],
      [:SEMI, ';'],
      [:R_CB, '}'],
      [:R_CB, '}']
    ]

    lexer = Chapex::Parser::Lexer.new(source.string)
    lexer.tokenize
    tokens = lexer.tokens

    assert_equal(30, tokens.length)
    tokens.each_with_index do |t, i|
      e = expects[i]
      check_token(t, e[0], e[1], e[2], e[3])
    end
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
